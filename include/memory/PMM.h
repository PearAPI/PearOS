#pragma once

#include "multiboot.h"
#include "stdint.h"

class PMM {
  public:
    void init(multiboot_info* multiboot_info, uint64_t kernel_base_address,
              uint8_t* bss_end);

  private:
    void mark_region_used(uint64_t addr, uint64_t size);
    void mark_region_free(uint64_t addr, uint64_t size);

    enum RegionType : uint8_t {
        AVAILABLE = 1,
        RESERVED = 2,
        ACPI_NVS = 3,
        FRAMEBUFFER = 4,
        BAD_MEMORY = 5,
    };

    uint64_t kernel_base;

    // each bit designates a 4KiB block of memory.
    // if bit is 1, block is used.
    uint8_t* bitmap;
};