#pragma once

#include <core/ISR.h>

typedef void (*IRQHandler)(Registers* regs);

void i686_IRQ_Initialize();
void i686_IRQ_RegisterHandler(uint8_t irq, IRQHandler handler);