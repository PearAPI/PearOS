#include "io/serial/Serial.h"
#include "interrupts/idt.h"
#include "io/io.h"
#include "pic.h"
#include "stdarg.h"

static Serial* active_instance;

void Serial::setDLAB() {
    uint8_t lcr = inb((uint16_t)comPort + LINE_CONTROL_REGISTER_OFFSET);
    outb((uint16_t)comPort + LINE_CONTROL_REGISTER_OFFSET, lcr | 0x80);
}

void Serial::clearDLAB() {
    uint8_t lcr = inb((uint16_t)comPort + LINE_CONTROL_REGISTER_OFFSET);
    outb((uint16_t)comPort + LINE_CONTROL_REGISTER_OFFSET, lcr & 0x7F);
}

void Serial::wait() {
    while ((inb((uint16_t)comPort + LINE_STATUS_REGISTER_OFFSET) & 0x20) == 0)
        ;
}

Serial::Serial(COM comPort, BaudRate baudRate, LineCoding lineCoding,
               FlowControl flowControl)
    : comPort(comPort), baudRate(baudRate), lineCoding(lineCoding),
      flowControl(flowControl) {}

void Serial::init() {
    active_instance = this;

    outb((uint16_t)comPort + INTERRUPT_REGISTER_OFFSET, 0x00);

    setBaud(baudRate);
    setLineCoding(lineCoding);
    enableFIFO();
    setFlowControl(flowControl);

    // Enable Interrupts
    outb((uint16_t)comPort + INTERRUPT_REGISTER_OFFSET, 0x01);

    uint8_t actual_irq = (comPort == COM::COM1 || comPort == COM::COM3) ? 4 : 3;
    register_interrupt_handler(32 + actual_irq, interrupt_handler);
    pic_unmask_irq(actual_irq);

    uint8_t mcr = inb((uint16_t)comPort + MODEM_CONTROL_REGISTER_OFFSET);
    outb((uint16_t)comPort + MODEM_CONTROL_REGISTER_OFFSET, mcr | 0x08);
}

static void serial_print_number(Serial& serial, int64_t num, int base, bool is_signed) {
    char buf[32];
    int i = 0;
    bool is_negative = false;

    // 1. Handle Zero explicitly
    if (num == 0) {
        serial.print("0", 1);
        return;
    }

    // 2. Handle Negative Numbers (Only for Base 10 + Signed)
    if (is_signed && base == 10 && num < 0) {
        is_negative = true;
        num = -num; // Make positive for processing
    }

    // 3. Process digits (work with unsigned to handle INT64_MIN safely)
    uint64_t unum = (uint64_t)num;

    while (unum > 0) {
        int digit = unum % base;
        if (digit < 10)
            buf[i++] = digit + '0';
        else
            buf[i++] = digit - 10 + 'A';
        unum /= base;
    }

    // 4. Print Negative Sign
    if (is_negative) {
        serial.print("-", 1);
    }

    // 5. Print buffer in reverse order
    while (i > 0) {
        serial.print(&buf[--i], 1);
    }
}

void Serial::setBaud(BaudRate baudRate) {
    uint16_t divisor = (uint16_t)baudRate; // Assuming enum holds the divisor

    setDLAB();
    outb((uint16_t)comPort + DATA_OFFSET, (uint8_t)(divisor & 0xFF));            // Low Byte
    outb((uint16_t)comPort + DATA_OFFSET + 1, (uint8_t)((divisor >> 8) & 0xFF)); // High Byte
    clearDLAB();
}

void Serial::setLineCoding(LineCoding lineCoding) {
    outb((uint16_t)comPort + LINE_CONTROL_REGISTER_OFFSET, (uint8_t)lineCoding);
}

void Serial::setFlowControl(FlowControl flowControl) {
    outb((uint16_t)comPort + MODEM_CONTROL_REGISTER_OFFSET,
         (uint8_t)flowControl);
}

void Serial::enableFIFO() {
    outb((uint16_t)comPort + INTERRUPT_IDENTIFICATION_REGISTER_OFFSET, 0xC7);
}

bool Serial::isDataAvailable() {
    return (inb((uint16_t)comPort + LINE_STATUS_REGISTER_OFFSET) & 1);
}

void Serial::println(const char* str, size_t len) {
    print(str, len);
    char c = '\n';
    print(&c, 1);
}

void Serial::print(const char* str, size_t len) {
    for (size_t i = 0; i < len; i++) {
        wait();

        outb((uint16_t)comPort + DATA_OFFSET, str[i]);
    }
}

void Serial::printf(const char* format, ...) {
    va_list args;
    va_start(args, format);
    vprintf(format, args);
    va_end(args);
}

void Serial::vprintf(const char* format, va_list args) {
    for (int i = 0; format[i] != '\0'; i++) {
        if (format[i] == '%') {
            i++;
            bool is_long = false;
            bool is_long_long = false;
            if (format[i] == 'l') {
                is_long = true;
                i++;
                if (format[i] == 'l') {
                    is_long_long = true;
                    i++;
                }
            }

            switch (format[i]) {
            case 'c': {
                char c = (char)va_arg(args, int);
                this->print(&c, 1);
                break;
            }
            case 's': {
                const char* s = va_arg(args, const char*);
                size_t len = 0;
                while (s[len] != '\0')
                    len++;
                this->print(s, len);
                break;
            }
            case 'd':
            case 'i': {
                int64_t d;
                if (is_long || is_long_long) {
                    d = va_arg(args, int64_t);
                } else {
                    d = va_arg(args, int);
                }
                serial_print_number(*this, d, 10, true);
                break;
            }
            case 'u': {
                uint64_t u;
                if (is_long || is_long_long) {
                    u = va_arg(args, uint64_t);
                } else {
                    u = va_arg(args, unsigned int);
                }
                serial_print_number(*this, u, 10, false);
                break;
            }
            case 'x':
            case 'X':
            case 'p': {
                uint64_t x;
                if (is_long || is_long_long || format[i] == 'p') {
                    x
                    = va_arg(args, uint64_t);
                } else {
                    x
                    = va_arg(args, unsigned int);
                }
                // Pass 'false' for unsigned (Hex is always unsigned)
                serial_print_number(*this, x, 16, false);
                break;
            }
            case '%': {
                this->print("%", 1);
                break;
            }
            default: {
                this->print("%", 1);
                this->print(&format[i], 1);
                break;
            }
            }
        } else {
            this->print(&format[i], 1);
        }
    }
}

char Serial::readChar() {
    while (!isDataAvailable())
        ;

    return (char)inb((uint16_t)comPort + DATA_OFFSET);
}

void Serial::setCallback(SerialCallback callback) {
    this->dataCallback = callback;
}

void Serial::interrupt_handler(struct CPUContext* context) {
    // 1. Safety check: do we have an instance?
    if (!active_instance) {
        // Just send EOI to unstick the system, though we shouldn't be here
        pic_send_eoi(4);
        return;
    }

    uint16_t port = (uint16_t)active_instance->comPort;

    // 2. Check Interrupt Identification Register (IIR)
    // Bit 0: 0 = Interrupt Pending, 1 = No Interrupt
    uint8_t iir = inb(port + INTERRUPT_IDENTIFICATION_REGISTER_OFFSET);

    // While an interrupt is pending...
    if ((iir & 0x01) == 0) {

        // 3. Check Line Status (Is Data Ready?)
        if (inb(port + LINE_STATUS_REGISTER_OFFSET) & 0x01) {

            // 4. READ THE CHARACTER
            // This is crucial! Reading the data register clears the interrupt.
            // If you don't do this, the UART will keep asserting the IRQ line.
            char c = inb(port + DATA_OFFSET);

            // 5. Call the user's debug handler
            if (active_instance->dataCallback) {
                active_instance->dataCallback(c);
            }
        }
    }

    // 6. Send EOI to PIC
    // Determine IRQ based on port
    uint8_t irq = (active_instance->comPort == COM::COM1 || active_instance->comPort == COM::COM3) ? 4 : 3;
    pic_send_eoi(irq);
}