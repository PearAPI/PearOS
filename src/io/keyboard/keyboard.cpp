#include "io/keyboard/keyboard.h"
#include "io/io.h"

// static uint8_t last_scancode = 0;

void Keyboard::init() {}

uint8_t read_scancode() {
    uint8_t scancode = inb(0x60);
    return scancode;
}

// void Keyboard::handle_interrupt(struct CPUContext* context) {
//     last_scancode = read_scancode();
//     pic_send_eoi(1);
// }

// char Keyboard::getLastCharAscii() {}