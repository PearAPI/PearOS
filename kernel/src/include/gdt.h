#pragma once

#ifdef __GDT__

#include <types.h>

#define GDT_ENTRY_COUNT 5

#define GDT_LIMIT_LOW(x) (x & 0xFFFF)
#define GDT_LIMIT_HIGH(x) ((x >> 16) & 0xF)

#define GDT_BASE_LOW(x) (x & 0xFFFF)
#define GDT_BASE_MIDDLE(x) ((x >> 16) & 0xFF)
#define GDT_BASE_HIGH(x) ((x >> 24) & 0xFF)

#define GDT_ACCESS_PRIVILEGE(x) ((x & 0x3) << 5)
#define GDT_ACCESS(x) (x & 0xFF)

#define GDT_VERIFY_FLAGS(x) ((x & 0b0110) != 0b0110)
#define GDT_COMBINE_FLAGS_LIMIT(x, y) ((x << 4) | y)


#define GDT_ACCESS_PRESENT 0x80
#define GDT_ACCESS_EXECUTABLE 0x8
#define GDT_ACCESS_DIRECTION 0x4
#define GDT_ACCESS_READWRITE 0x2
#define GDT_ACCESS_ACCESSED 0x1

#define GDT_FLAGS_GRANULARITY 0x80
#define GDT_FLAGS_SIZE 0x40
#define GDT_FLAGS_LONGMODE 0x20

#define GDT_ACCESS_KERNEL 0x0
#define GDT_ACCESS_USER 0x60

typedef struct {
    uint8_t base_low;
    uint8_t flags_limit;
    uint8_t access;
    uint8_t base_middle;
    uint16_t base_high;
    uint16_t limit_low;
} __attribute__((packed)) gdt_entry_t;

typedef struct {
    uintptr_t size;
} __attribute__((packed)) gftr_t;

typedef struct {
    uint16_t size;
    uintptr_t offset;
} __attribute__((packed)) gdtr_t;

gdt_entry_t gdt[GDT_ENTRY_COUNT];

void init_gdt();

#endif