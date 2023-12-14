#include <core/HAL/HAL.h>

#define ASM __asm__ volatile

void kernel_main() {
    ASM("cli");
    HAL_Initialize();

    

    for(;;){}
}
