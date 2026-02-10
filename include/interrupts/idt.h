#pragma once
#include "stdint.h"

#define PACKED __attribute__((packed))

typedef void (*InterruptHandler)(struct CPUContext*);

enum InterruptVector : uint8_t {
    TIMER = 0x20,
    KEYBOARD = 0x21,
    SERIAL = 0x24,
};

// Define the attributes byte explicitly or using clean bitfields
// Standard x86-64 Interrupt Gate: Type=0xE, S=0, DPL=0, P=1 => 0x8E
struct IDT_Attributes {
    uint8_t ist_index : 3; // Interrupt Stack Table index (0-7)
    uint8_t reserved0 : 5; // Must be 0
    uint8_t type : 4;      // Gate Type (0xE = Interrupt Gate)
    uint8_t zero : 1;      // Reserved/S bit (0 for Interrupt Gate)
    uint8_t dpl : 2;       // Descriptor Privilege Level (0=Kernel, 3=User)
    uint8_t present : 1;   // Present bit (Must be 1)
} PACKED;

// 3. The exact 16-byte structure required by the CPU
struct IDT_Entry {
    uint16_t offset_low;
    uint16_t selector;
    uint8_t ist;
    uint8_t attributes;
    uint16_t offset_mid;
    uint32_t offset_high;
    uint32_t reserved;
} __attribute__((packed));

// 4. Pointer structure for the 'lidt' instruction
struct IDTR {
    uint16_t limit;
    uint64_t base;
} PACKED;

// 5. EXTERN declaration (Fixes "Multiple Definition" linker error)
extern struct IDT_Entry idt[256];
extern struct IDTR idtr;

// Functions
void idt_init();
void idt_set_entry(uint8_t vector, InterruptHandler handler, uint8_t dpl);
void register_interrupt_handler(uint8_t vector, InterruptHandler handler);