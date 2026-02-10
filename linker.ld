ENTRY(_start)

KERNEL_VIRTUAL_BASE = 0xFFFFFFFF80000000;
KERNEL_PHYSICAL_BASE = 0x100000;

PHDRS
{
    boot    PT_LOAD    FLAGS(5); /* Read + Execute */
    kernel  PT_LOAD    FLAGS(7); /* Read + Write + Execute */
}

SECTIONS
{
    /* 1. Start at 1MB Physical */
    . = KERNEL_PHYSICAL_BASE;
    
    /* Export the Physical Start (0x100000) */
    _load_start_addr = .;

    .boot :
    {
        KEEP(*(.multiboot))
        *(.boot)
        *(.boot.data)
        *(.boot.bss)
        . = ALIGN(4096);
    } :boot

    /* 2. Advance to High Memory */
    . += KERNEL_VIRTUAL_BASE;

    .text : AT(ADDR(.text) - KERNEL_VIRTUAL_BASE)
    {
        *(.text)
    } :kernel

    .init_array : AT(ADDR(.init_array) - KERNEL_VIRTUAL_BASE)
    {
        /* Define the start symbol */
        PROVIDE_HIDDEN (__init_array_start = .);
        
        /* Keep these sections from being discarded */
        KEEP (*(SORT(.init_array.*)))
        KEEP (*(.init_array*))
        
        /* Define the end symbol */
        PROVIDE_HIDDEN (__init_array_end = .);
    } :kernel

    .rodata : AT(ADDR(.rodata) - KERNEL_VIRTUAL_BASE)
    {
        *(.rodata)
    } :kernel

    .data : AT(ADDR(.data) - KERNEL_VIRTUAL_BASE)
    {
        *(.data)
    } :kernel

    /* 3. Export the Physical End of the "Loaded" part (Code + Data, NO BSS) */
    /* This tells GRUB how many bytes to read from the disk */
    _load_end_addr = . - KERNEL_VIRTUAL_BASE;

    .bss : AT(ADDR(.bss) - KERNEL_VIRTUAL_BASE)
    {
        *(COMMON)
        *(.bss)
    } :kernel

    /* 4. Export the Physical End of the BSS */
    /* This tells GRUB how much memory to zero out after loading */
    _bss_end_addr = . - KERNEL_VIRTUAL_BASE;
}