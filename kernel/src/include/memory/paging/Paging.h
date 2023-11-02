#pragma once

#include <types.h>

#define PAGETABLE_SIZE 512

#define PAGE_TABLE_PRESENT 0x1
#define PAGE_TABLE_WRITABLE 0x2
#define PAGE_TABLE_USER 0x4
#define PAGE_TABLE_WRITETHOUGH 0x8
#define PAGE_TABLE_NOT_CACHEABLE 0x10
#define PAGE_TABLE_ACCESSED 0x20
#define PAGE_TABLE_DIRTY 0x40
#define PAGE_TABLE_HUGE 0x80
#define PAGE_TABLE_GLOBAL 0x100
#define PAGE_TABLE_NO_EXECUTE 0x8000000000000000

#define PAGE_TABLE_ENTRY_ADDRESS_MASK 0x000FFFFFFFFFF000

typedef struct {
    uintptr_t entries[PAGETABLE_SIZE];
} L1PageTable_t;

typedef struct {
    uintptr_t entries[PAGETABLE_SIZE];
} L2PageTable_t;

typedef struct {
    uintptr_t entries[PAGETABLE_SIZE];
} L3PageTable_t;

typedef struct {
    L3PageTable_t entries[PAGETABLE_SIZE];
} PageDirectory_t;

typedef PageDirectory_t L4PageTable_t;

typedef struct {
    PageDirectory_t* pageDirectory;
    uintptr_t virtualAddress;
    uintptr_t physicalAddress;
    uint64_t flags;
} MemoryMap_t;

extern PageDirectory_t* kernelPageDirectory;

PageDirectory_t* createIdentityPageDirectory();
void setupPaging();

void mapPage(PageDirectory_t* pageDirectory, uintptr_t virtualAddress, uintptr_t physicalAddress, uint64_t flags);
void unmapPage(PageDirectory_t* pageDirectory, uintptr_t virtualAddress);