#include <gdt.h>

#ifdef __GDT__

void init_gdt() {
    // null descriptor
    gdt[0] = NULL;

    // code segment descriptor
    gdt_entry_t segment_descriptor = (gdt_entry_t) 0xFFFFFFFFFFFFFFFF;
    segment_descriptor.limit_low = GDT_GDT_LIMIT_LOW(0xFFFFF);
    segment_descriptor.flags_limit = GDT_COMBINE_FLAGS_LIMIT(GDT_FLAGS_LONGMODE, (GDT_LIMIT_HIGH(0xFFFFF)));
    segment_descriptor.access = GDT_ACCESS_PRESENT | GDT_ACCESS(0) | GDT_ACCESS_EXECUTABLE | GDT_ACCESS_READWRITE;
    segment_descriptor.base_middle = GDT_BASE_MIDDLE(0);
    segment_descriptor.base_high = GDT_BASE_HIGH(0);
    segment_descriptor.limit_low = GDT_LIMIT_LOW(0xFFFFF);

    gdt[1] = segment_descriptor;

    // data segment descriptor
    segment_descriptor.limit_low = GDT_GDT_LIMIT_LOW(0xFFFFF);
    segment_descriptor.flags_limit = GDT_COMBINE_FLAGS_LIMIT(GDT_FLAGS_LONGMODE, (GDT_LIMIT_HIGH(0xFFFFF)));
    segment_descriptor.access = GDT_ACCESS_PRESENT | GDT_ACCESS(0) | GDT_ACCESS_READWRITE;
    segment_descriptor.base_middle = GDT_BASE_MIDDLE(0);
    segment_descriptor.base_high = GDT_BASE_HIGH(0);
    segment_descriptor.limit_low = GDT_LIMIT_LOW(0xFFFFF);    

    gdt[2] = segment_descriptor;

    // load gdt
    gdt_ptr_t gdt_ptr = gdt_ptr_t{sizeof(gdt) - 1, (uint64_t) gdt};
    asm("lgdt %0" : : "m"(gdt_ptr));
}

#endif