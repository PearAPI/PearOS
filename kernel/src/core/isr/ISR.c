#include <stdio.h>
#include <core/ISR.h>
#include <core/GDT.h>
#include <core/IDT.h>
#include <core/IO/io.h>

ISRHandler g_ISRHandlers[256];

static const char* const g_Exceptions[] = {
    "Divide by zero error",
    "Debug",
    "Non-maskable Interrupt",
    "Breakpoint",
    "Overflow",
    "Bound Range Exceeded",
    "Invalid Opcode",
    "Device Not Available",
    "Double Fault",
    "Coprocessor Segment Overrun",
    "Invalid TSS",
    "Segment Not Present",
    "Stack-Segment Fault",
    "General Protection Fault",
    "Page Fault",
    "",
    "x87 Floating-Point Exception",
    "Alignment Check",
    "Machine Check",
    "SIMD Floating-Point Exception",
    "Virtualization Exception",
    "Control Protection Exception ",
    "",
    "",
    "",
    "",
    "",
    "",
    "Hypervisor Injection Exception",
    "VMM Communication Exception",
    "Security Exception",
    ""
};

void i686_ISR_Initialize() {
    i686_ISR_InitializeGates();

    for(int i = 0; i < 256; i++)
        i686_IDT_EnableGate(i);

    i686_IDT_DisableGate(0x50);
}

void __attribute__((cdecl)) i686_ISR_handler(Registers* regs)
{
    if(g_ISRHandlers[regs->int_no] != 0)
        g_ISRHandlers[regs->int_no](regs);
    else if(regs->int_no >= 32) {
        printf("Unhandled interrupt: %d\n", regs->int_no);
    }
    else {
        printf("Unhandled exception %d %s\n", regs->int_no, g_Exceptions[regs->int_no]);
        
        printf("  eax=%x  ebx=%x  ecx=%x  edx=%x  esi=%x  edi=%x\n",
               regs->eax, regs->ebx, regs->ecx, regs->edx, regs->esi, regs->edi);

        printf("  esp=%x  ebp=%x  eip=%x  eflags=%x  cs=%x  ds=%x  ss=%x\n",
               regs->esp, regs->ebp, regs->eip, regs->eflags, regs->cs, regs->ds, regs->ss);

        printf("  interrupt=%x  errorcode=%x\n", regs->int_no, regs->err_code);
        printf("KERNEL PANIC\n");
        i686_panic();
    }
}