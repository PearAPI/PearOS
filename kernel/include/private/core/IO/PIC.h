#pragma once

#include <stdint.h>

void i686_PIC_Initialize(uint8_t offsetPic1, uint8_t offsetPic2);
void i686_PIC_SendEOI(uint8_t irq);
void i686_PIC_Disable();
void i686_PIC_Mask(uint8_t irq);
void i686_PIC_Unmask(uint8_t irq);
uint16_t i686_PIC_ReadIRQRequestRegister();
uint16_t i686_PIC_ReadinServiceRegister();
