#pragma once

#include "stdint.h"

// Represents a single entry in the memory map
struct multiboot_memory_map {
    uint32_t size; // Size of this entry (usually 20 or 24 bytes)
    uint64_t addr; // Base address of the memory region
    uint64_t len;  // Length of the region in bytes
    uint32_t
        type; // Type: 1 = Available RAM, others = Reserved/ACPI/Hibernation
} __attribute__((packed));

// The main structure passed to the kernel
struct multiboot_info {
    uint32_t flags; // Validity flags (Bit 6 means mmap_* are valid)

    // Available memory from BIOS (mem_lower/mem_upper)
    // Only valid if flags[0] is set
    uint32_t mem_lower;
    uint32_t mem_upper;

    uint32_t boot_device; // "root" partition
    uint32_t cmdline;     // Kernel command line string address

    uint32_t mods_count; // Number of modules loaded
    uint32_t mods_addr;  // Address of the first module structure

    // ELF section headers or a.out symbol table
    uint32_t syms[4];

    // Memory Map (The critical part for PMM)
    // Only valid if flags[6] is set
    uint32_t mmap_length; // Total size of the buffer
    uint32_t mmap_addr;   // Physical address of the buffer

    // ... there are more fields (drives, config table, boot loader name, APM,
    // VBE) but you typically don't need them for a basic kernel.
};
