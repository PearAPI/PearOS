global _start
global kernelPageDirectory

extern kernel_main

section .text
[bits 32]
_start:
    mov esp, stack_top

    call check_multiboot
    call check_cpuid
    
    call kernel_main

    hlt

check_multiboot:
    cmp eax, 0x36d76289
    jne .not_multiboot

    ret

.not_multiboot:
    mov al, 'M'
    jmp error

check_cpuid:
	pushfd
    pop eax
    mov ecx, eax
    xor eax, 1 << 21
    push eax
    popfd
    pushfd
    pop eax
    push ecx
    popfd
    xor eax, ecx
    jz .no_cpuid
    ret

.no_cpuid:
    mov al, 'C'
    jmp error

check_long_mode:
	mov eax, 0x80000000
	cpuid
	cmp eax, 0x80000001
	jb .no_long_mode

	mov eax, 0x80000001
	cpuid
	test edx, 1 << 29
	jz .no_long_mode
	
	ret
.no_long_mode:
    mov al, 'L'
    jmp error

error:
    mov dword [0xb8000], 0x4f524f45
    mov dword [0xb8004], 0x4f3A4f52
    mov byte [0xb8008], al
    mov dword [0xb800a], 0x00200020
    hlt

setup_paging:
    mov eax, cr0                                   ; Set the A-register to control register 0.
    and eax, 01111111111111111111111111111111b     ; Clear the PG-bit, which is bit 31.
    mov cr0, eax

    mov eax, L3_page_table
    or eax, 0b11 ; Present, Writable
    mov dword [kernelPageDirectory], eax

    mov eax, L2_page_table
    or eax, 0b11 ; Present, Writable
    mov dword [L3_page_table + 4*0], eax

    mov ecx, 0  
.loop:

    mov eax, 0x200000 ; 2 MiB
    mul ecx
    or eax, 0b10000011 ; Present, Writable, Huge
    mov [L2_page_table + ecx * 8], eax

    inc ecx
    cmp ecx, 512
    jne .loop

    ret

enable_paging:
    ; pass page table address to cr3
    mov eax, kernelPageDirectory
    mov cr3, eax

    ; enable PAE
    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    ; enable long mode
    mov ecx, 0xc0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    ; enable paging
    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax

    ret

section .bss
align 4096

kernelPageDirectory:
    resb 4096 ; 4 KiB
L3_page_table:
    resb 4096 ; 4 KiB
L2_page_table:

stack_bottom:
    resb 4096*4 ; 16 KiB
stack_top:

section .rodata
gdt64:
	dq 0 ; zero entry
.code_segment: equ $ - gdt64
	dw 0xffff ; limit
	dw 0 ; base
	db 0 ; base
	db 10011010b ; access
	db 10101111b ; flags(paged 32 bit) & granularity
	db 0 ; base
.data_segment:
	dw 0xffff ; limit
	dw 0 ; base
	db 0 ; base
	db 10010010b ; access
	db 10101111b ; flags(paged 32 bit) & granularity
	db 0 ; base	
.pointer:
	dw $ - gdt64 - 1 ; length
	dq gdt64 ; address

