#pragma once

#include "stdint.h"

struct CPUContext {
    // 1. Pushed by 'push_all' (Last pushed = Lowest Offset)
    uint64_t rax; // Offset 0
    uint64_t rbx;
    uint64_t rcx;
    uint64_t rdx;
    uint64_t rsi;
    uint64_t rdi;
    uint64_t rbp;
    uint64_t r8;
    uint64_t r9;
    uint64_t r10;
    uint64_t r11;
    uint64_t r12;
    uint64_t r13;
    uint64_t r14;
    uint64_t r15; // Offset 112

    // 2. Pushed manually by the stub
    uint64_t interrupt_number;
    uint64_t error_code;

    // 3. Pushed automatically by CPU
    uint64_t rip;
    uint64_t cs;
    uint64_t rflags;
    uint64_t rsp;
    uint64_t ss;
} __attribute__((packed));