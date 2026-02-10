section .multiboot
global multiboot_header
extern _start
extern _load_start_addr
extern _load_end_addr
extern _bss_end_addr

align 4
multiboot_header:
    dd 0x1BADB002               ; Magic
    dd 0x10003                  ; Flags: Align(1) + MemInfo(2) + AddressFields(0x10000)
    dd -(0x1BADB002 + 0x10003)  ; Checksum

    ; Address Fields (REQUIRED for Higher Half Kernel)
    dd multiboot_header         ; Header Address
    dd _load_start_addr         ; Load Start
    dd _load_end_addr           ; Load End
    dd _bss_end_addr            ; BSS End
    dd _start                   ; Entry Point