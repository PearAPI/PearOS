global long_mode_start

extern kernel_main

section .text
[bits 64]

long_mode_start:
    ; set segemnt registers to 0
    mov ax, 0
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    hlt
