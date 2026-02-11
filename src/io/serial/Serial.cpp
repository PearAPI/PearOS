#include "io/serial/Serial.h"
#include "interrupts/idt.h" // Your interrupt registration
#include "interrupts/interrupt.h"
#include "io/io.h" // Your inb/outb helpers
#include "pic.h"   // Your PIC helpers

struct CPUContext;

// 1. DEFINE THE STATIC POINTER (Fixes your linker error)
Serial* Serial::irq4_instance = nullptr;
Serial* Serial::irq3_instance = nullptr;

Serial::Serial(COM port) : port(port) {}

void Serial::init() {
    bool is_irq4 = (port == COM::COM1 || port == COM::COM3);

    if (is_irq4) {
        irq4_instance = this;
    } else {
        irq3_instance = this;
    }

    // 1. Disable Interrupts during setup
    outb((uint16_t)port + INT_ENABLE, 0x00);

    // 2. Set Baud Rate (38400 or 115200)
    // Enable DLAB (Set baud rate divisor)
    outb((uint16_t)port + LINE_CTRL, 0x80);
    // Set Divisor (3 = 38400 baud, 1 = 115200 baud)
    outb((uint16_t)port + DATA_REG, 0x03);   // Low Byte
    outb((uint16_t)port + INT_ENABLE, 0x00); // High Byte

    // 3. Configure Line (8 bits, No Parity, 1 Stop Bit)
    // Clear DLAB (0x7F) and set 8N1 (0x03)
    outb((uint16_t)port + LINE_CTRL, 0x03);

    // 4. Enable FIFO (Clear buffers, 14-byte trigger)
    outb((uint16_t)port + FIFO_CTRL, 0xC7);

    // 5. Enable Interrupts (MCR: Aux Output 2 is needed for interrupts on PC)
    outb((uint16_t)port + MODEM_CTRL, 0x0B);

    // 6. Enable RX Interrupts Only (TX will be enabled when we write)
    outb((uint16_t)port + INT_ENABLE, 0x01);

    // 7. Register ISR (IRQ 4 for COM1, IRQ 3 for COM2)
    uint8_t irq = (port == COM::COM1) ? 4 : 3;
    register_interrupt_handler(32 + irq, interrupt_handler);
    pic_unmask_irq(irq);

    initialized = true;
}

// --- Writing Data ---

void Serial::write(char c) {
    // 1. Push data to buffer
    // Disable interrupts briefly to ensure atomic push
    asm volatile("cli");
    txBuffer.push(c);
    asm volatile("sti");

    // 2. Start sending!
    startTransmission();
}

void Serial::write(const char* str) {
    while (*str) {
        write(*str++);
    }
}

void Serial::startTransmission() {
    // To start sending, we enable the "Transmitter Holding Register Empty" (THRE) interrupt.
    // The UART will immediately trigger an interrupt because it's empty,
    // and our ISR will handle popping the byte and writing it.

    uint8_t ier = inb((uint16_t)port + INT_ENABLE);
    outb((uint16_t)port + INT_ENABLE, ier | 0x02); // Bit 1 = TX Empty Int
}

// --- Reading Data ---

bool Serial::available() {
    return !rxBuffer.isEmpty();
}

char Serial::read() {
    if (rxBuffer.isEmpty())
        return 0;

    asm volatile("cli");
    char c = rxBuffer.pop();
    asm volatile("sti");
    return c;
}

// --- The Polling Fallback ---
void Serial::writeSync(char c) {
    while ((inb((uint16_t)port + LINE_STATUS) & 0x20) == 0)
        ;
    outb((uint16_t)port + DATA_REG, c);
}

// --- THE INTERRUPT HANDLER ---

void Serial::interrupt_handler(CPUContext* ctx) {
    Serial* device = nullptr;

    // Assuming your IDT maps IRQ0->32, IRQ3->35, IRQ4->36
    if (ctx->interrupt_number == 36) { // IRQ 4 (COM1 / COM3)
        device = irq4_instance;
    } else if (ctx->interrupt_number == 35) { // IRQ 3 (COM2 / COM4)
        device = irq3_instance;
    }

    if (!device) {
        return;
    }

    uint16_t port = (uint16_t)device->port;

    // Read Interrupt Identification Register (IIR)
    // We loop because multiple interrupts might be pending
    while (true) {
        uint8_t iir = inb(port + INT_IDENT);

        // Bit 0 = 1 means NO interrupt pending
        if (iir & 0x01)
            break;

        // Mask to get the Interrupt ID (Bits 1-2)
        uint8_t id = iir & 0x06;

        if (id == 0x04) {
            // === RX DATA RECEIVED ===
            while (inb(port + LINE_STATUS) & 0x01) {
                char c = inb(port + DATA_REG);

                // 1. Push to buffer (Standard logic)
                device->rxBuffer.push(c);

                // 2. NEW: Notify the Debugger (if attached)
                if (device->dataCallback) {
                    device->dataCallback(c);
                }
            }
        } else if (id == 0x02) {
            // === TX TRANSMITTER EMPTY ===
            // We can send more data now!

            if (!device->txBuffer.isEmpty()) {
                // Pop next byte and send
                char c = device->txBuffer.pop();
                outb(port + DATA_REG, c);
            } else {
                // Buffer Empty? DISABLE TX Interrupts
                // Otherwise, the UART will loop-interrupt us forever saying "I'm empty!"
                uint8_t ier = inb(port + INT_ENABLE);
                outb(port + INT_ENABLE, ier & ~0x02);
            }
        }
    }
}

// Helper for printf to print a number
static void print_number(Serial* serial, int64_t num, int base) {
    char buf[32];
    int i = 0;
    int is_negative = 0;

    if (num == 0) {
        serial->write('0');
        return;
    }

    // Handle negative numbers for base 10
    if (num < 0 && base == 10) {
        is_negative = 1;
        num = -num;
    }

    // Handle unsigned for hex by casting if needed, but for simplicity here
    // treating as int. If exact unsigned behavior is needed we should probably
    // pass unsigned int to a helper
    uint64_t unum = (uint64_t)num;

    while (unum > 0) {
        int digit = unum % base;
        if (digit < 10)
            buf[i++] = digit + '0';
        else
            buf[i++] = digit - 10 + 'A';
        unum /= base;
    }

    if (is_negative) {
        serial->write('-');
    }

    while (i > 0) {
        serial->write(buf[--i]);
    }
}

static void print_pointer(Serial* serial, void* ptr) {
    serial->write("0x");
    print_number(serial, (int64_t)ptr, 16);
}

void Serial::vprintf(const char* fmt, va_list args) {
    for (int i = 0; fmt[i] != '\0'; i++) {
        if (fmt[i] == '%') {
            i++;
            switch (fmt[i]) {
            case 'c': {
                char c = (char)va_arg(args, int);
                write(c);
                break;
            }
            case 's': {
                const char* s = va_arg(args, const char*);
                write(s);
                break;
            }
            case 'd':
            case 'i': {
                int d = va_arg(args, int);
                print_number(this, d, 10);
                break;
            }
            case 'x':
            case 'X': {
                int x
                = va_arg(args, int);
                write("0x");
                print_number(this, x, 16);
                break;
            }
            case 'p': {
                void* p = va_arg(args, void*);
                print_pointer(this, p);
                break;
            }
            case '%': {
                write('%');
                break;
            }
            default: {
                write('%');
                write(fmt[i]);
                break;
            }
            }
        } else {
            write(fmt[i]);
        }
    }
}

void Serial::printf(const char* fmt, ...) {
    va_list args;
    va_start(args, fmt);
    vprintf(fmt, args);
    va_end(args);
}

void Serial::setCallback(SerialCallback callback) {
    // We disable interrupts briefly to ensure we don't trigger
    // a half-set callback if an interrupt fires right now.
    asm volatile("cli");
    this->dataCallback = callback;
    asm volatile("sti");
}