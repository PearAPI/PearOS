#include <core/HAL/HAL.h>
#include <stdio.h>

#define asm(x) __asm__ volatile(x)

void crash_me();

void kernel_main() {
    clrscr();

    HAL_Initialize();

    asm("int $0x50");

    printf("Hello, World!\n");

    for(;;){}
}
