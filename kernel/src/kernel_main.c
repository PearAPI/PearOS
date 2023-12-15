#include <core/HAL/HAL.h>
#include <stdio.h>
#include <core/IO/IRQ.h>

#define asm(x) __asm__ volatile(x)

void crash_me();

void timer(Registers* regs) {
    printf(".");
}

void kernel_main() {
    clrscr();
    HAL_Initialize();

    i686_IRQ_RegisterHandler(0, timer); // timer

    printf("Hello, World!\n");

    for(;;){}
}
