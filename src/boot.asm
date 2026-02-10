%define KERNEL_VIRTUAL_BASE 0xFFFFFFFF80000000
%define V2P(x) ((x) - KERNEL_VIRTUAL_BASE)

section .boot
global _start
global stack_top
extern start64

bits 32

_start:
    cli
    mov esp, stack_top

    mov [multiboot_magic_storage], eax
    mov [multiboot_info_storage], ebx

    ; load gdt
    lgdt [gdt_descriptor]

    call checkCPUIDSupport
    cmp eax, 1
    jne .no_cpuid

    call checkLongMode
    cmp eax, 1
    jne .no_long_mode

    call disablePaging
    call enablePAE
    
    ; FIX: Load CR3 before enabling Long Mode
    call setupPaging

    ; enable long mode (EFER MSR)
    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    ; enable paging (CR0)
    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax

    ; far jump to 64-bit code
    jmp 0x18:trampoline64

.hang:
    hlt
    jmp .hang

.no_cpuid:
    mov esi, no_cpuid_msg
    call print_string
    jmp .hang

.no_long_mode:
    mov esi, no_long_mode_msg
    call print_string
    jmp .hang


setupPaging:
    ; We need to map:
    ; 1. Identity (Virtual 0 -> Physical 0) for the current IP to keep running.
    ; 2. Higher Half (Virtual 0xFFFFFFFF80000000 -> Physical 0) for the kernel.

    mov edi, pml4_table
    xor eax, eax
    mov ecx, 3072   ; 3072 * 4 bytes = 12288 bytes (3 pages)
    rep stosd       ; Clear memory [edi]...[edi+12288]

    ; --- LEVEL 4 (PML4) ---
    ; Map PML4[0] -> PDPT (For Identity Low Map)
    mov eax, page_directory_pointer_table
    or eax, 0b11 ; Present + Writable
    mov edi, pml4_table
    mov [edi], eax  ; Index 0
    mov dword [edi + 4], 0

    ; Map PML4[511] -> PDPT (For Higher Half Map)
    ; Note: We reuse the SAME PDPT for simplicity.
    ; 511 * 8 = 4088
    mov [edi + 4088], eax 
    mov dword [edi + 4092], 0


    ; --- LEVEL 3 (PDPT) ---
    ; Map PDPT[0] -> Page Directory (For Identity Low Map)
    mov eax, page_directory_table
    or eax, 0b11 ; Present + Writable
    mov edi, page_directory_pointer_table
    mov [edi], eax ; Index 0
    mov dword [edi + 4], 0

    ; Map PDPT[510] -> Page Directory (For Higher Half Map -2GB)
    ; 510 * 8 = 4080
    mov [edi + 4080], eax
    mov dword [edi + 4084], 0


    ; --- LEVEL 2 (Page Directory) ---
    ; Map PD[0] -> Physical Address 0 (2MB Huge Page)
    ; This handles BOTH the Identity Map (via PDPT[0]) 
    ; AND the High Map (via PDPT[510]) because they point to this same table.
    mov eax, 0          ; Physical address 0
    or eax, 0x83        ; Present + Writable + HUGE PAGE (Bit 7)
    mov edi, page_directory_table
    mov [edi], eax      ; Index 0 set to Physical 0MB-2MB
    mov dword [edi + 4], 0

    ; --- LOAD CR3 ---
    mov eax, pml4_table
    mov cr3, eax
    ret

enablePAE:
    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax
    ret

disablePaging:
    mov eax, cr0
    and eax, 0x7FFFFFFF
    mov cr0, eax
    ret

checkLongMode:
    mov eax, 0x80000000
    cpuid
    cmp eax, 0x80000001
    jb .no_long_mode_fail

    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29
    jz .no_long_mode_fail
    mov eax, 1
    ret
.no_long_mode_fail:
    mov eax, 0
    ret

checkCPUIDSupport:
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
    cmp eax, ecx
    je .no_cpuid_fail
    mov eax, 1
    ret
.no_cpuid_fail:
    mov eax, 0
    ret

print_string:
    pusha
    mov edx, 0xB8000 ; VGA Text Buffer Address
.loop:
    mov al, [esi]
    test al, al
    jz .done
    mov [edx], al
    mov byte [edx+1], 0x0F ; White on Black
    add edx, 2
    inc esi
    jmp .loop
.done:
    popa
    ret

bits 64
trampoline64:
    ; Update Segment Registers
    mov ax, 0x20 ; Offset for 64-bit Data Segment
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    xor rdi, rdi
    xor rsi, rsi

    mov edi, [multiboot_magic_storage]  ; Moves 32-bits, zeroes top 32-bits automatically
    mov esi, [multiboot_info_storage]   ; Moves 32-bits, zeroes top 32-bits automatically

    mov rax, start64
    jmp rax

section .boot.data
bits 32

no_cpuid_msg db "No CPUID support", 0
no_long_mode_msg db "No long mode support", 0

multiboot_magic_storage dd 0
multiboot_info_storage  dd 0

; ... (Your GDT is actually correct! Keep it exactly as you wrote it) ...
; ... (Make sure gdt_descriptor uses 'dq gdt_start' as you did) ...
gdt_start:
    dq 0x0000000000000000
    ; 32-bit Code (Offset 0x08)
    dw 0xFFFF, 0x0000
    db 0x00, 10011010b, 11001111b, 0x00
    ; 32-bit Data (Offset 0x10)
    dw 0xFFFF, 0x0000
    db 0x00, 10010010b, 11001111b, 0x00
    ; 64-bit Code (Offset 0x18)
    dw 0x0000, 0x0000
    db 0x00, 10011010b, 10101111b, 0x00
    ; 64-bit Data (Offset 0x20)
    dw 0x0000, 0x0000
    db 0x00, 10010010b, 00000000b, 0x00
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dq gdt_start

align 4096
; WE NEED 3 LEVELS OF TABLES FOR 64-BIT HUGE PAGES
pml4_table:
    times 4096 db 0
page_directory_pointer_table:
    times 4096 db 0
page_directory_table:
    times 4096 db 0

align 16
stack_bottom:
    times 4096 db 0
stack_top: