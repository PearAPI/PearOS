#include "pic.h"
#include "io/io.h"
#include "io/serial/SerialLog.h"

#define PIC1_COMMAND 0x20
#define PIC1_DATA 0x21
#define PIC2_COMMAND 0xA0
#define PIC2_DATA 0xA1

// A small wait is needed between PIC commands on older hardware/some emulators
void io_wait() { outb(0x80, 0); }

void pic_remap() {
    // uint8_t a1, a2;

    // Save current masks (so we don't accidentally enable things we didn't
    // want)
    // a1 = inb(PIC1_DATA);
    // a2 = inb(PIC2_DATA);

    // ICW1: Start initialization sequence (in cascade mode)
    outb(PIC1_COMMAND, 0x11);
    io_wait();
    outb(PIC2_COMMAND, 0x11);
    io_wait();

    // ICW2: Vector Offset
    // Map Master PIC (IRQ 0-7) to Vector 0x20 (32)
    // Map Slave PIC  (IRQ 8-15) to Vector 0x28 (40)
    outb(PIC1_DATA, 0x20);
    io_wait(); // Master -> 32
    outb(PIC2_DATA, 0x28);
    io_wait(); // Slave -> 40

    // ICW3: Tell Master/Slave how they are connected
    outb(PIC1_DATA, 4);
    io_wait(); // Tell Master there is a Slave at IRQ2 (0000 0100)
    outb(PIC2_DATA, 2);
    io_wait(); // Tell Slave its cascade identity (0000 0010)

    // ICW4: Environment info
    outb(PIC1_DATA, 0x01);
    io_wait(); // 8086/88 (MCS-80/85) mode
    outb(PIC2_DATA, 0x01);
    io_wait();

    outb(PIC1_DATA, 0xFF);
    outb(PIC2_DATA, 0xFF);
}

void pic_mask_irq(uint8_t irq) {
    uint16_t port;
    uint8_t value;

    if (irq < 8) {
        port = PIC1_DATA;
    } else {
        port = PIC2_DATA;
        irq -= 8;
    }

    // Read current mask, flip the specific bit to 1 (disable), write back
    value = inb(port) | (1 << irq);
    outb(port, value);
}

void pic_unmask_irq(uint8_t irq) {
    uint16_t port;
    uint8_t value;

    if (irq < 8) {
        port = PIC1_DATA;
    } else {
        port = PIC2_DATA;
        irq -= 8;
    }

    // Read current mask, flip the specific bit to 0 (enable), write back
    value = inb(port) & ~(1 << irq);
    outb(port, value);
}

void pic_send_eoi(int irq) {
    // If the IRQ came from the Slave PIC (IRQ 8-15), we must tell the Slave to
    // calm down.
    if (irq >= 8)
        outb(PIC2_COMMAND, 0x20);

    // We must ALWAYS tell the Master PIC to calm down.
    outb(PIC1_COMMAND, 0x20);
}