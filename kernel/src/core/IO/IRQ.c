#include <core/IO/IRQ.h>
#include <core/IO/PIC.h>
#include <core/IO/io.h>
#include <stdio.h>
#include <stddef.h>

#define PIC1_REMAP_OFFSET 0x20

IRQHandler g_IRQHandlers[16];

void i686_IRQ_Handler(Registers* regs) {
    uint8_t irq = regs->int_no - PIC1_REMAP_OFFSET;

    if(g_IRQHandlers[irq] != NULL) {
        // call IRQ handler
        g_IRQHandlers[irq](regs);
    }
    else
        printf("Unhandled IRQ %d\n", irq);

    // send EOI to PIC
    i686_PIC_SendEOI(irq);
}

void i686_IRQ_Initialize() {
    i686_PIC_Initialize(PIC1_REMAP_OFFSET, PIC1_REMAP_OFFSET + 8);

    // register IRQ handlers
    for(uint8_t i = 0; i < 16; i++)
        i686_ISR_RegisterHandler(i + PIC1_REMAP_OFFSET, i686_IRQ_Handler);
    
    // enable interrupts
    i686_EnableInterrupts();
}

void i686_IRQ_RegisterHandler(uint8_t irq, IRQHandler handler) {
    g_IRQHandlers[irq] = handler;
}