#pragma once

#include <stdint.h>

typedef struct 
{
    // in reverse order of pushing

    uint32_t ds;
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    uint32_t int_no, err_code;
    uint32_t eip, cs, eflags, useresp, ss;
} __attribute__((packed)) Registers;

typedef void (*ISRHandler)(Registers* regs);

void i686_ISR_InitializeGates();

void i686_ISR_Initialize();
void i686_ISR_RegisterHandler(uint8_t interrupt);