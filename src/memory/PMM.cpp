#include "memory/PMM.h"
#include "multiboot.h"
#include "stdint.h"

#include "io/serial/SerialLog.h"

#define V2P(x) ((x) - KERNEL_VIRTUAL_BASE)

#define PAGE_SIZE 0x1000

void PMM::init(multiboot_info* multiboot_info, uint64_t kernel_base_address,
               uint8_t* bss_end) {
    bitmap = bss_end;

    // iterate memory map
    uintptr_t mmap_address = (uintptr_t)multiboot_info->mmap_addr;
    uintptr_t mmap_end = mmap_address + multiboot_info->mmap_length;

    while (mmap_address < mmap_end) {
        multiboot_memory_map* current = (multiboot_memory_map*)mmap_address;

        switch (current->type) {
        case RegionType::AVAILABLE:
            mark_region_free(current->addr, current->len);
            break;
        case RegionType::RESERVED:
        case RegionType::ACPI_NVS:
        case RegionType::FRAMEBUFFER:
            mark_region_used(current->addr, current->len);
            break;
        case RegionType::BAD_MEMORY:
            LOG_ERROR("Bad Memory Region: 0x%p - 0x%p", current->addr, current->addr + current->len);
            break;
        default:
            LOG_INFO("Unknown Memory Region: 0x%p - 0x%p, Type: %d", current->addr, current->addr + current->len, current->type);
            mark_region_used(current->addr, current->len);
            break;
        }

        LOG_DEBUG("Memory Region: 0x%p - 0x%p, Type: %d", current->addr, current->addr + current->len, current->type);

        mmap_address += current->size + sizeof(current->size);
    }
}

void PMM::mark_region_used(uint64_t addr, uint64_t size) {
    uint64_t start_page = addr / PAGE_SIZE;
    uint64_t end_page = (addr + size) / PAGE_SIZE;

    LOG_INFO("Marking region used: 0x%p - 0x%p", addr, addr + size);

    for (uint64_t i = start_page; i < end_page; i++) {
        bitmap[i] = 1;
    }
}

void PMM::mark_region_free(uint64_t addr, uint64_t size) {
    uint64_t start_page = addr / PAGE_SIZE;
    uint64_t end_page = (addr + size) / PAGE_SIZE;

    LOG_INFO("Marking region free: 0x%p - 0x%p", addr, addr + size);

    for (uint64_t i = start_page; i < end_page; i++) {
        bitmap[i] = 0;
    }
}