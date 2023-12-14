#include <core/HAL/HAL.h>

#include <core/GDT.h>
#include <core/IDT.h>
#include <core/ISR.h>

void HAL_Initialize()
{
    i686_GDT_Initialize();
    i686_IDT_Initialize();
    i686_ISR_Initialize();
}
