#pragma once

#include "stdint.h"

class Keyboard {
  public:
    void init();

    static void interrupt_handler(struct CPUContext* context);

    char getLastCharAscii();
};