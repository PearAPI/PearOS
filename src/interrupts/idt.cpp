#include "interrupts/idt.h"
#include "interrupts/interrupt.h"
#include "pic.h"

#define asm(x) __asm__ volatile(x)

// Actual definition of the global variables
struct IDT_Entry idt[256];
struct IDTR idtr;

InterruptHandler interrupt_handlers[256];

extern "C" void* isr_stub_table[];

void idt_init() {
    for (int i = 0; i < 256; i++) {
        // Connect the Assembly Stub (isr_stub_table[i]) to the IDT Entry
        idt_set_entry(i, (InterruptHandler)isr_stub_table[i], 0x8E);
    }

    idtr.base = (uint64_t)&idt;
    idtr.limit = sizeof(struct IDT_Entry) * 256 - 1;

    // Load the IDT
    asm("lidt %0" : : "m"(idtr));

    asm("sti");
}

void idt_set_entry(uint8_t vector, InterruptHandler handler, uint8_t dpl) {
    uint64_t ptr = (uint64_t)handler;

    idt[vector].offset_low = (uint16_t)ptr;
    idt[vector].selector = 0x18;

    // IST = 0 (Classic stack mechanism)
    idt[vector].ist = 0;

    // Type: 0xE (Interrupt Gate), Present: 1
    // Attributes byte construction:
    // P(1) | DPL(2) | S(0) | Type(4)
    // 1      00       0      1110    => 0x8E (for Ring 0)
    idt[vector].attributes = 0x8E | (dpl << 5);

    idt[vector].offset_mid = (uint16_t)(ptr >> 16);
    idt[vector].offset_high = (uint32_t)(ptr >> 32);
    idt[vector].reserved = 0;
}

extern "C" void interrupt_handler(CPUContext* context) {
    uint8_t interrupt_number = context->interrupt_number;

    if (interrupt_handlers[interrupt_number] != nullptr) {
        interrupt_handlers[interrupt_number](context);
    }

    if (context->interrupt_number >= 32 && context->interrupt_number <= 47) {
        uint8_t irq_no = context->interrupt_number - 32;
        pic_send_eoi(irq_no);
    }
}

void register_interrupt_handler(uint8_t vector, InterruptHandler handler) {
    interrupt_handlers[vector] = handler;
}