#include <core/IO/PIC.h>
#include <core/IO/io.h>

#define PIC1_COMMAND_PORT   0x20
#define PIC1_DATA_PORT      0x21
#define PIC2_COMMAND_PORT   0xA0
#define PIC2_DATA_PORT      0xA1

enum {
    PIC_ICW1_ICW4       = 0x01, // ICW4 (not) needed
    PIC_ICW1_SINGLE     = 0x02, // Single (cascade) mode
    PIC_ICW1_INTERVAL4  = 0x04, // Call address interval 4 (8)
    PIC_ICW1_LEVEL      = 0x08, // Level triggered (edge) mode
    PIC_ICW1_INITIALIZE = 0x10, // Initialization

} PIC_ICW1;

enum {
    PIC_ICW4_8086                   = 0x1,  // 8086/88 mode
    PIC_ICW4_AUTO_EOI               = 0x2,  // Auto EOI
    PIC_ICW4_BUFFERED_MASTER        = 0x4,  // Buffered mode/slave
    PIC_ICW4_BUFFERED_SAVE          = 0x0,  // Buffered mode/master
    PIC_ICW4_BUFFERED               = 0x8,  // Buffered mode/master
    PIC_ICW4_SFNM                   = 0x10, // Special fully nested
} PIC_ICW4;

enum {
    PIC_CMD_END_OF_INTERRUPT = 0x20,
    PIC_CMD_READ_IRR         = 0x0A,
    PIC_CMD_READ_ISR         = 0x0B,
} PIC_CMD;

void i686_PIC_Initialize(uint8_t offsetPic1, uint8_t offsetPic2) {
    // initialization word 1
    i686_outb(PIC1_COMMAND_PORT, PIC_ICW1_INITIALIZE | PIC_ICW1_ICW4);
    i686_io_wait();
    i686_outb(PIC2_COMMAND_PORT, PIC_ICW1_INITIALIZE | PIC_ICW1_ICW4);
    i686_io_wait();

    // initialization word 2 - offsets
    i686_outb(PIC1_DATA_PORT, offsetPic1);
    i686_io_wait();
    i686_outb(PIC2_DATA_PORT, offsetPic2);
    i686_io_wait();

    // initialization word 3 - cascade
    i686_outb(PIC1_DATA_PORT, 0x04);    // PIC2 at IRQ2          (0000 0100)
    i686_io_wait();
    i686_outb(PIC2_DATA_PORT, 0x02);    // PIC2 cascade identity (0000 0010)
    i686_io_wait();

    // initialization word 4 - environment
    i686_outb(PIC1_DATA_PORT, PIC_ICW4_8086);
    i686_io_wait();
    i686_outb(PIC2_DATA_PORT, PIC_ICW4_8086);
    i686_io_wait();

    // clear data registers
    i686_outb(PIC1_DATA_PORT, 0x00);
    i686_io_wait();
    i686_outb(PIC2_DATA_PORT, 0x00);
    i686_io_wait();
}

void i686_PIC_Mask(uint8_t irq) {
    uint16_t port;
    uint8_t value;

    if (irq < 8) {
        port = PIC1_DATA_PORT;
    } else {
        port = PIC2_DATA_PORT;
        irq -= 8;
    }

    value = i686_inb(port) | (1 << irq);
    i686_io_wait();
    i686_outb(port, value);
    i686_io_wait();
}

void i686_PIC_Unmask(uint8_t irq) {
    uint16_t port;
    uint8_t value;

    if (irq < 8) {
        port = PIC1_DATA_PORT;
    } else {
        port = PIC2_DATA_PORT;
        irq -= 8;
    }

    value = i686_inb(port) & (~(1 << irq));
    i686_io_wait();
    i686_outb(port, value);
    i686_io_wait();
}

void i686_PIC_Disable() {
    i686_outb(PIC1_DATA_PORT, 0xFF);
    i686_io_wait();
    i686_outb(PIC2_DATA_PORT, 0xFF);
    i686_io_wait();
}

void i686_PIC_SendEOI(uint8_t irq) {
    if (irq >= 8)
        i686_outb(PIC2_COMMAND_PORT, PIC_CMD_END_OF_INTERRUPT);

    i686_outb(PIC1_COMMAND_PORT, PIC_CMD_END_OF_INTERRUPT);
}

uint16_t i686_PIC_ReadIRQRequestRegister() {
    i686_outb(PIC1_COMMAND_PORT, PIC_CMD_READ_IRR);
    i686_outb(PIC2_COMMAND_PORT, PIC_CMD_READ_IRR);

    return i686_inb(PIC1_COMMAND_PORT) | (i686_inb(PIC2_COMMAND_PORT) << 8);
}

uint16_t i686_PIC_ReadinServiceRegister() {
    i686_outb(PIC1_COMMAND_PORT, PIC_CMD_READ_ISR);
    i686_outb(PIC2_COMMAND_PORT, PIC_CMD_READ_ISR);

    return i686_inb(PIC1_COMMAND_PORT) | (i686_inb(PIC2_COMMAND_PORT) << 8);
}