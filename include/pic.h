#pragma once

#include "stdint.h"

void io_wait();

void pic_remap();

void pic_mask_irq(uint8_t irq);
void pic_unmask_irq(uint8_t irq);

void pic_send_eoi(int irq);