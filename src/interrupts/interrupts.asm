section .text
align 16
bits 64

extern interrupt_handler; define macro for pushing all registers in order
%macro push_all 0
    push r15
    push r14
    push r13
    push r12
    push r11
    push r10
    push r9
    push r8
    push rbp
    push rdi
    push rsi
    push rdx
    push rcx
    push rbx
    push rax
%endmacro

; define macro for popping all registers in order
%macro pop_all 0
    pop rax
    pop rbx
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    pop r8
    pop r9
    pop r10
    pop r11
    pop r12
    pop r13
    pop r14
    pop r15
%endmacro

interrupt_stub_0:
    push 0                  ; 1. Push Dummy Error
    push 0                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_1:
    push 0                  ; 1. Push Dummy Error
    push 1                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_2:
    push 0                  ; 1. Push Dummy Error
    push 2                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_3:
    push 0                  ; 1. Push Dummy Error
    push 3                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_4:
    push 0                  ; 1. Push Dummy Error
    push 4                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_5:
    push 0                  ; 1. Push Dummy Error
    push 5                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_6:
    push 0                  ; 1. Push Dummy Error
    push 6                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_7:
    push 0                  ; 1. Push Dummy Error
    push 7                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_8:
                            ; 1. Error Code already pushed by CPU
    push 8                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. Pass stack pointer
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_9:
    push 0                  ; 1. Push Dummy Error
    push 9                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_10:
                            ; 1. Error Code already pushed by CPU
    push 10                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. Pass stack pointer
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_11:
                            ; 1. Error Code already pushed by CPU
    push 11                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. Pass stack pointer
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_12:
                            ; 1. Error Code already pushed by CPU
    push 12                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. Pass stack pointer
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_13:
                            ; 1. Error Code already pushed by CPU
    push 13                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. Pass stack pointer
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_14:
                            ; 1. Error Code already pushed by CPU
    push 14                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. Pass stack pointer
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_15:
    push 0                  ; 1. Push Dummy Error
    push 15                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_16:
    push 0                  ; 1. Push Dummy Error
    push 16                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_17:
    push 0                  ; 1. Push Dummy Error
    push 17                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_18:
    push 0                  ; 1. Push Dummy Error
    push 18                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_19:
    push 0                  ; 1. Push Dummy Error
    push 19                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_20:
    push 0                  ; 1. Push Dummy Error
    push 20                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_21:
    push 0                  ; 1. Push Dummy Error
    push 21                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_22:
    push 0                  ; 1. Push Dummy Error
    push 22                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_23:
    push 0                  ; 1. Push Dummy Error
    push 23                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_24:
    push 0                  ; 1. Push Dummy Error
    push 24                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_25:
    push 0                  ; 1. Push Dummy Error
    push 25                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_26:
    push 0                  ; 1. Push Dummy Error
    push 26                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_27:
    push 0                  ; 1. Push Dummy Error
    push 27                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_28:
    push 0                  ; 1. Push Dummy Error
    push 28                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_29:
    push 0                  ; 1. Push Dummy Error
    push 29                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_30:
    push 0                  ; 1. Push Dummy Error
    push 30                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_31:
    push 0                  ; 1. Push Dummy Error
    push 31                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_32:
    push 0                  ; 1. Push Dummy Error
    push 32                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_33:
    push 0                  ; 1. Push Dummy Error
    push 33                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_34:
    push 0                  ; 1. Push Dummy Error
    push 34                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_35:
    push 0                  ; 1. Push Dummy Error
    push 35                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_36:
    push 0                  ; 1. Push Dummy Error
    push 36                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_37:
    push 0                  ; 1. Push Dummy Error
    push 37                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_38:
    push 0                  ; 1. Push Dummy Error
    push 38                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_39:
    push 0                  ; 1. Push Dummy Error
    push 39                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_40:
    push 0                  ; 1. Push Dummy Error
    push 40                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_41:
    push 0                  ; 1. Push Dummy Error
    push 41                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_42:
    push 0                  ; 1. Push Dummy Error
    push 42                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_43:
    push 0                  ; 1. Push Dummy Error
    push 43                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_44:
    push 0                  ; 1. Push Dummy Error
    push 44                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_45:
    push 0                  ; 1. Push Dummy Error
    push 45                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_46:
    push 0                  ; 1. Push Dummy Error
    push 46                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_47:
    push 0                  ; 1. Push Dummy Error
    push 47                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_48:
    push 0                  ; 1. Push Dummy Error
    push 48                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_49:
    push 0                  ; 1. Push Dummy Error
    push 49                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_50:
    push 0                  ; 1. Push Dummy Error
    push 50                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_51:
    push 0                  ; 1. Push Dummy Error
    push 51                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_52:
    push 0                  ; 1. Push Dummy Error
    push 52                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_53:
    push 0                  ; 1. Push Dummy Error
    push 53                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_54:
    push 0                  ; 1. Push Dummy Error
    push 54                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_55:
    push 0                  ; 1. Push Dummy Error
    push 55                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_56:
    push 0                  ; 1. Push Dummy Error
    push 56                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_57:
    push 0                  ; 1. Push Dummy Error
    push 57                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_58:
    push 0                  ; 1. Push Dummy Error
    push 58                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_59:
    push 0                  ; 1. Push Dummy Error
    push 59                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_60:
    push 0                  ; 1. Push Dummy Error
    push 60                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_61:
    push 0                  ; 1. Push Dummy Error
    push 61                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_62:
    push 0                  ; 1. Push Dummy Error
    push 62                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_63:
    push 0                  ; 1. Push Dummy Error
    push 63                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_64:
    push 0                  ; 1. Push Dummy Error
    push 64                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_65:
    push 0                  ; 1. Push Dummy Error
    push 65                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_66:
    push 0                  ; 1. Push Dummy Error
    push 66                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_67:
    push 0                  ; 1. Push Dummy Error
    push 67                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_68:
    push 0                  ; 1. Push Dummy Error
    push 68                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_69:
    push 0                  ; 1. Push Dummy Error
    push 69                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_70:
    push 0                  ; 1. Push Dummy Error
    push 70                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_71:
    push 0                  ; 1. Push Dummy Error
    push 71                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_72:
    push 0                  ; 1. Push Dummy Error
    push 72                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_73:
    push 0                  ; 1. Push Dummy Error
    push 73                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_74:
    push 0                  ; 1. Push Dummy Error
    push 74                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_75:
    push 0                  ; 1. Push Dummy Error
    push 75                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_76:
    push 0                  ; 1. Push Dummy Error
    push 76                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_77:
    push 0                  ; 1. Push Dummy Error
    push 77                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_78:
    push 0                  ; 1. Push Dummy Error
    push 78                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_79:
    push 0                  ; 1. Push Dummy Error
    push 79                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_80:
    push 0                  ; 1. Push Dummy Error
    push 80                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_81:
    push 0                  ; 1. Push Dummy Error
    push 81                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_82:
    push 0                  ; 1. Push Dummy Error
    push 82                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_83:
    push 0                  ; 1. Push Dummy Error
    push 83                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_84:
    push 0                  ; 1. Push Dummy Error
    push 84                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_85:
    push 0                  ; 1. Push Dummy Error
    push 85                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_86:
    push 0                  ; 1. Push Dummy Error
    push 86                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_87:
    push 0                  ; 1. Push Dummy Error
    push 87                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_88:
    push 0                  ; 1. Push Dummy Error
    push 88                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_89:
    push 0                  ; 1. Push Dummy Error
    push 89                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_90:
    push 0                  ; 1. Push Dummy Error
    push 90                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_91:
    push 0                  ; 1. Push Dummy Error
    push 91                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_92:
    push 0                  ; 1. Push Dummy Error
    push 92                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_93:
    push 0                  ; 1. Push Dummy Error
    push 93                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_94:
    push 0                  ; 1. Push Dummy Error
    push 94                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_95:
    push 0                  ; 1. Push Dummy Error
    push 95                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_96:
    push 0                  ; 1. Push Dummy Error
    push 96                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_97:
    push 0                  ; 1. Push Dummy Error
    push 97                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_98:
    push 0                  ; 1. Push Dummy Error
    push 98                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_99:
    push 0                  ; 1. Push Dummy Error
    push 99                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_100:
    push 0                  ; 1. Push Dummy Error
    push 100                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_101:
    push 0                  ; 1. Push Dummy Error
    push 101                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_102:
    push 0                  ; 1. Push Dummy Error
    push 102                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_103:
    push 0                  ; 1. Push Dummy Error
    push 103                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_104:
    push 0                  ; 1. Push Dummy Error
    push 104                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_105:
    push 0                  ; 1. Push Dummy Error
    push 105                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_106:
    push 0                  ; 1. Push Dummy Error
    push 106                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_107:
    push 0                  ; 1. Push Dummy Error
    push 107                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_108:
    push 0                  ; 1. Push Dummy Error
    push 108                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_109:
    push 0                  ; 1. Push Dummy Error
    push 109                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_110:
    push 0                  ; 1. Push Dummy Error
    push 110                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_111:
    push 0                  ; 1. Push Dummy Error
    push 111                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_112:
    push 0                  ; 1. Push Dummy Error
    push 112                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_113:
    push 0                  ; 1. Push Dummy Error
    push 113                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_114:
    push 0                  ; 1. Push Dummy Error
    push 114                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_115:
    push 0                  ; 1. Push Dummy Error
    push 115                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_116:
    push 0                  ; 1. Push Dummy Error
    push 116                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_117:
    push 0                  ; 1. Push Dummy Error
    push 117                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_118:
    push 0                  ; 1. Push Dummy Error
    push 118                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_119:
    push 0                  ; 1. Push Dummy Error
    push 119                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_120:
    push 0                  ; 1. Push Dummy Error
    push 120                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_121:
    push 0                  ; 1. Push Dummy Error
    push 121                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_122:
    push 0                  ; 1. Push Dummy Error
    push 122                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_123:
    push 0                  ; 1. Push Dummy Error
    push 123                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_124:
    push 0                  ; 1. Push Dummy Error
    push 124                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_125:
    push 0                  ; 1. Push Dummy Error
    push 125                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_126:
    push 0                  ; 1. Push Dummy Error
    push 126                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_127:
    push 0                  ; 1. Push Dummy Error
    push 127                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_128:
    push 0                  ; 1. Push Dummy Error
    push 128                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_129:
    push 0                  ; 1. Push Dummy Error
    push 129                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_130:
    push 0                  ; 1. Push Dummy Error
    push 130                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_131:
    push 0                  ; 1. Push Dummy Error
    push 131                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_132:
    push 0                  ; 1. Push Dummy Error
    push 132                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_133:
    push 0                  ; 1. Push Dummy Error
    push 133                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_134:
    push 0                  ; 1. Push Dummy Error
    push 134                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_135:
    push 0                  ; 1. Push Dummy Error
    push 135                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_136:
    push 0                  ; 1. Push Dummy Error
    push 136                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_137:
    push 0                  ; 1. Push Dummy Error
    push 137                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_138:
    push 0                  ; 1. Push Dummy Error
    push 138                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_139:
    push 0                  ; 1. Push Dummy Error
    push 139                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_140:
    push 0                  ; 1. Push Dummy Error
    push 140                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_141:
    push 0                  ; 1. Push Dummy Error
    push 141                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_142:
    push 0                  ; 1. Push Dummy Error
    push 142                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_143:
    push 0                  ; 1. Push Dummy Error
    push 143                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_144:
    push 0                  ; 1. Push Dummy Error
    push 144                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_145:
    push 0                  ; 1. Push Dummy Error
    push 145                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_146:
    push 0                  ; 1. Push Dummy Error
    push 146                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_147:
    push 0                  ; 1. Push Dummy Error
    push 147                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_148:
    push 0                  ; 1. Push Dummy Error
    push 148                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_149:
    push 0                  ; 1. Push Dummy Error
    push 149                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_150:
    push 0                  ; 1. Push Dummy Error
    push 150                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_151:
    push 0                  ; 1. Push Dummy Error
    push 151                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_152:
    push 0                  ; 1. Push Dummy Error
    push 152                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_153:
    push 0                  ; 1. Push Dummy Error
    push 153                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_154:
    push 0                  ; 1. Push Dummy Error
    push 154                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_155:
    push 0                  ; 1. Push Dummy Error
    push 155                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_156:
    push 0                  ; 1. Push Dummy Error
    push 156                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_157:
    push 0                  ; 1. Push Dummy Error
    push 157                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_158:
    push 0                  ; 1. Push Dummy Error
    push 158                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_159:
    push 0                  ; 1. Push Dummy Error
    push 159                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_160:
    push 0                  ; 1. Push Dummy Error
    push 160                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_161:
    push 0                  ; 1. Push Dummy Error
    push 161                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_162:
    push 0                  ; 1. Push Dummy Error
    push 162                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_163:
    push 0                  ; 1. Push Dummy Error
    push 163                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_164:
    push 0                  ; 1. Push Dummy Error
    push 164                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_165:
    push 0                  ; 1. Push Dummy Error
    push 165                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_166:
    push 0                  ; 1. Push Dummy Error
    push 166                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_167:
    push 0                  ; 1. Push Dummy Error
    push 167                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_168:
    push 0                  ; 1. Push Dummy Error
    push 168                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_169:
    push 0                  ; 1. Push Dummy Error
    push 169                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_170:
    push 0                  ; 1. Push Dummy Error
    push 170                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_171:
    push 0                  ; 1. Push Dummy Error
    push 171                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_172:
    push 0                  ; 1. Push Dummy Error
    push 172                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_173:
    push 0                  ; 1. Push Dummy Error
    push 173                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_174:
    push 0                  ; 1. Push Dummy Error
    push 174                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_175:
    push 0                  ; 1. Push Dummy Error
    push 175                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_176:
    push 0                  ; 1. Push Dummy Error
    push 176                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_177:
    push 0                  ; 1. Push Dummy Error
    push 177                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_178:
    push 0                  ; 1. Push Dummy Error
    push 178                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_179:
    push 0                  ; 1. Push Dummy Error
    push 179                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_180:
    push 0                  ; 1. Push Dummy Error
    push 180                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_181:
    push 0                  ; 1. Push Dummy Error
    push 181                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_182:
    push 0                  ; 1. Push Dummy Error
    push 182                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_183:
    push 0                  ; 1. Push Dummy Error
    push 183                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_184:
    push 0                  ; 1. Push Dummy Error
    push 184                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_185:
    push 0                  ; 1. Push Dummy Error
    push 185                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_186:
    push 0                  ; 1. Push Dummy Error
    push 186                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_187:
    push 0                  ; 1. Push Dummy Error
    push 187                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_188:
    push 0                  ; 1. Push Dummy Error
    push 188                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_189:
    push 0                  ; 1. Push Dummy Error
    push 189                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_190:
    push 0                  ; 1. Push Dummy Error
    push 190                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_191:
    push 0                  ; 1. Push Dummy Error
    push 191                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_192:
    push 0                  ; 1. Push Dummy Error
    push 192                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_193:
    push 0                  ; 1. Push Dummy Error
    push 193                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_194:
    push 0                  ; 1. Push Dummy Error
    push 194                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_195:
    push 0                  ; 1. Push Dummy Error
    push 195                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_196:
    push 0                  ; 1. Push Dummy Error
    push 196                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_197:
    push 0                  ; 1. Push Dummy Error
    push 197                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_198:
    push 0                  ; 1. Push Dummy Error
    push 198                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_199:
    push 0                  ; 1. Push Dummy Error
    push 199                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_200:
    push 0                  ; 1. Push Dummy Error
    push 200                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_201:
    push 0                  ; 1. Push Dummy Error
    push 201                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_202:
    push 0                  ; 1. Push Dummy Error
    push 202                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_203:
    push 0                  ; 1. Push Dummy Error
    push 203                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_204:
    push 0                  ; 1. Push Dummy Error
    push 204                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_205:
    push 0                  ; 1. Push Dummy Error
    push 205                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_206:
    push 0                  ; 1. Push Dummy Error
    push 206                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_207:
    push 0                  ; 1. Push Dummy Error
    push 207                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_208:
    push 0                  ; 1. Push Dummy Error
    push 208                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_209:
    push 0                  ; 1. Push Dummy Error
    push 209                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_210:
    push 0                  ; 1. Push Dummy Error
    push 210                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_211:
    push 0                  ; 1. Push Dummy Error
    push 211                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_212:
    push 0                  ; 1. Push Dummy Error
    push 212                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_213:
    push 0                  ; 1. Push Dummy Error
    push 213                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_214:
    push 0                  ; 1. Push Dummy Error
    push 214                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_215:
    push 0                  ; 1. Push Dummy Error
    push 215                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_216:
    push 0                  ; 1. Push Dummy Error
    push 216                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_217:
    push 0                  ; 1. Push Dummy Error
    push 217                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_218:
    push 0                  ; 1. Push Dummy Error
    push 218                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_219:
    push 0                  ; 1. Push Dummy Error
    push 219                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_220:
    push 0                  ; 1. Push Dummy Error
    push 220                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_221:
    push 0                  ; 1. Push Dummy Error
    push 221                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_222:
    push 0                  ; 1. Push Dummy Error
    push 222                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_223:
    push 0                  ; 1. Push Dummy Error
    push 223                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_224:
    push 0                  ; 1. Push Dummy Error
    push 224                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_225:
    push 0                  ; 1. Push Dummy Error
    push 225                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_226:
    push 0                  ; 1. Push Dummy Error
    push 226                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_227:
    push 0                  ; 1. Push Dummy Error
    push 227                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_228:
    push 0                  ; 1. Push Dummy Error
    push 228                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_229:
    push 0                  ; 1. Push Dummy Error
    push 229                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_230:
    push 0                  ; 1. Push Dummy Error
    push 230                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_231:
    push 0                  ; 1. Push Dummy Error
    push 231                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_232:
    push 0                  ; 1. Push Dummy Error
    push 232                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_233:
    push 0                  ; 1. Push Dummy Error
    push 233                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_234:
    push 0                  ; 1. Push Dummy Error
    push 234                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_235:
    push 0                  ; 1. Push Dummy Error
    push 235                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_236:
    push 0                  ; 1. Push Dummy Error
    push 236                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_237:
    push 0                  ; 1. Push Dummy Error
    push 237                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_238:
    push 0                  ; 1. Push Dummy Error
    push 238                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_239:
    push 0                  ; 1. Push Dummy Error
    push 239                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_240:
    push 0                  ; 1. Push Dummy Error
    push 240                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_241:
    push 0                  ; 1. Push Dummy Error
    push 241                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_242:
    push 0                  ; 1. Push Dummy Error
    push 242                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_243:
    push 0                  ; 1. Push Dummy Error
    push 243                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_244:
    push 0                  ; 1. Push Dummy Error
    push 244                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_245:
    push 0                  ; 1. Push Dummy Error
    push 245                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_246:
    push 0                  ; 1. Push Dummy Error
    push 246                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_247:
    push 0                  ; 1. Push Dummy Error
    push 247                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_248:
    push 0                  ; 1. Push Dummy Error
    push 248                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_249:
    push 0                  ; 1. Push Dummy Error
    push 249                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_250:
    push 0                  ; 1. Push Dummy Error
    push 250                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_251:
    push 0                  ; 1. Push Dummy Error
    push 251                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_252:
    push 0                  ; 1. Push Dummy Error
    push 252                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_253:
    push 0                  ; 1. Push Dummy Error
    push 253                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_254:
    push 0                  ; 1. Push Dummy Error
    push 254                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

interrupt_stub_255:
    push 0                  ; 1. Push Dummy Error
    push 255                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq

section .data
global isr_stub_table
isr_stub_table:
    dq interrupt_stub_0
    dq interrupt_stub_1
    dq interrupt_stub_2
    dq interrupt_stub_3
    dq interrupt_stub_4
    dq interrupt_stub_5
    dq interrupt_stub_6
    dq interrupt_stub_7
    dq interrupt_stub_8
    dq interrupt_stub_9
    dq interrupt_stub_10
    dq interrupt_stub_11
    dq interrupt_stub_12
    dq interrupt_stub_13
    dq interrupt_stub_14
    dq interrupt_stub_15
    dq interrupt_stub_16
    dq interrupt_stub_17
    dq interrupt_stub_18
    dq interrupt_stub_19
    dq interrupt_stub_20
    dq interrupt_stub_21
    dq interrupt_stub_22
    dq interrupt_stub_23
    dq interrupt_stub_24
    dq interrupt_stub_25
    dq interrupt_stub_26
    dq interrupt_stub_27
    dq interrupt_stub_28
    dq interrupt_stub_29
    dq interrupt_stub_30
    dq interrupt_stub_31
    dq interrupt_stub_32
    dq interrupt_stub_33
    dq interrupt_stub_34
    dq interrupt_stub_35
    dq interrupt_stub_36
    dq interrupt_stub_37
    dq interrupt_stub_38
    dq interrupt_stub_39
    dq interrupt_stub_40
    dq interrupt_stub_41
    dq interrupt_stub_42
    dq interrupt_stub_43
    dq interrupt_stub_44
    dq interrupt_stub_45
    dq interrupt_stub_46
    dq interrupt_stub_47
    dq interrupt_stub_48
    dq interrupt_stub_49
    dq interrupt_stub_50
    dq interrupt_stub_51
    dq interrupt_stub_52
    dq interrupt_stub_53
    dq interrupt_stub_54
    dq interrupt_stub_55
    dq interrupt_stub_56
    dq interrupt_stub_57
    dq interrupt_stub_58
    dq interrupt_stub_59
    dq interrupt_stub_60
    dq interrupt_stub_61
    dq interrupt_stub_62
    dq interrupt_stub_63
    dq interrupt_stub_64
    dq interrupt_stub_65
    dq interrupt_stub_66
    dq interrupt_stub_67
    dq interrupt_stub_68
    dq interrupt_stub_69
    dq interrupt_stub_70
    dq interrupt_stub_71
    dq interrupt_stub_72
    dq interrupt_stub_73
    dq interrupt_stub_74
    dq interrupt_stub_75
    dq interrupt_stub_76
    dq interrupt_stub_77
    dq interrupt_stub_78
    dq interrupt_stub_79
    dq interrupt_stub_80
    dq interrupt_stub_81
    dq interrupt_stub_82
    dq interrupt_stub_83
    dq interrupt_stub_84
    dq interrupt_stub_85
    dq interrupt_stub_86
    dq interrupt_stub_87
    dq interrupt_stub_88
    dq interrupt_stub_89
    dq interrupt_stub_90
    dq interrupt_stub_91
    dq interrupt_stub_92
    dq interrupt_stub_93
    dq interrupt_stub_94
    dq interrupt_stub_95
    dq interrupt_stub_96
    dq interrupt_stub_97
    dq interrupt_stub_98
    dq interrupt_stub_99
    dq interrupt_stub_100
    dq interrupt_stub_101
    dq interrupt_stub_102
    dq interrupt_stub_103
    dq interrupt_stub_104
    dq interrupt_stub_105
    dq interrupt_stub_106
    dq interrupt_stub_107
    dq interrupt_stub_108
    dq interrupt_stub_109
    dq interrupt_stub_110
    dq interrupt_stub_111
    dq interrupt_stub_112
    dq interrupt_stub_113
    dq interrupt_stub_114
    dq interrupt_stub_115
    dq interrupt_stub_116
    dq interrupt_stub_117
    dq interrupt_stub_118
    dq interrupt_stub_119
    dq interrupt_stub_120
    dq interrupt_stub_121
    dq interrupt_stub_122
    dq interrupt_stub_123
    dq interrupt_stub_124
    dq interrupt_stub_125
    dq interrupt_stub_126
    dq interrupt_stub_127
    dq interrupt_stub_128
    dq interrupt_stub_129
    dq interrupt_stub_130
    dq interrupt_stub_131
    dq interrupt_stub_132
    dq interrupt_stub_133
    dq interrupt_stub_134
    dq interrupt_stub_135
    dq interrupt_stub_136
    dq interrupt_stub_137
    dq interrupt_stub_138
    dq interrupt_stub_139
    dq interrupt_stub_140
    dq interrupt_stub_141
    dq interrupt_stub_142
    dq interrupt_stub_143
    dq interrupt_stub_144
    dq interrupt_stub_145
    dq interrupt_stub_146
    dq interrupt_stub_147
    dq interrupt_stub_148
    dq interrupt_stub_149
    dq interrupt_stub_150
    dq interrupt_stub_151
    dq interrupt_stub_152
    dq interrupt_stub_153
    dq interrupt_stub_154
    dq interrupt_stub_155
    dq interrupt_stub_156
    dq interrupt_stub_157
    dq interrupt_stub_158
    dq interrupt_stub_159
    dq interrupt_stub_160
    dq interrupt_stub_161
    dq interrupt_stub_162
    dq interrupt_stub_163
    dq interrupt_stub_164
    dq interrupt_stub_165
    dq interrupt_stub_166
    dq interrupt_stub_167
    dq interrupt_stub_168
    dq interrupt_stub_169
    dq interrupt_stub_170
    dq interrupt_stub_171
    dq interrupt_stub_172
    dq interrupt_stub_173
    dq interrupt_stub_174
    dq interrupt_stub_175
    dq interrupt_stub_176
    dq interrupt_stub_177
    dq interrupt_stub_178
    dq interrupt_stub_179
    dq interrupt_stub_180
    dq interrupt_stub_181
    dq interrupt_stub_182
    dq interrupt_stub_183
    dq interrupt_stub_184
    dq interrupt_stub_185
    dq interrupt_stub_186
    dq interrupt_stub_187
    dq interrupt_stub_188
    dq interrupt_stub_189
    dq interrupt_stub_190
    dq interrupt_stub_191
    dq interrupt_stub_192
    dq interrupt_stub_193
    dq interrupt_stub_194
    dq interrupt_stub_195
    dq interrupt_stub_196
    dq interrupt_stub_197
    dq interrupt_stub_198
    dq interrupt_stub_199
    dq interrupt_stub_200
    dq interrupt_stub_201
    dq interrupt_stub_202
    dq interrupt_stub_203
    dq interrupt_stub_204
    dq interrupt_stub_205
    dq interrupt_stub_206
    dq interrupt_stub_207
    dq interrupt_stub_208
    dq interrupt_stub_209
    dq interrupt_stub_210
    dq interrupt_stub_211
    dq interrupt_stub_212
    dq interrupt_stub_213
    dq interrupt_stub_214
    dq interrupt_stub_215
    dq interrupt_stub_216
    dq interrupt_stub_217
    dq interrupt_stub_218
    dq interrupt_stub_219
    dq interrupt_stub_220
    dq interrupt_stub_221
    dq interrupt_stub_222
    dq interrupt_stub_223
    dq interrupt_stub_224
    dq interrupt_stub_225
    dq interrupt_stub_226
    dq interrupt_stub_227
    dq interrupt_stub_228
    dq interrupt_stub_229
    dq interrupt_stub_230
    dq interrupt_stub_231
    dq interrupt_stub_232
    dq interrupt_stub_233
    dq interrupt_stub_234
    dq interrupt_stub_235
    dq interrupt_stub_236
    dq interrupt_stub_237
    dq interrupt_stub_238
    dq interrupt_stub_239
    dq interrupt_stub_240
    dq interrupt_stub_241
    dq interrupt_stub_242
    dq interrupt_stub_243
    dq interrupt_stub_244
    dq interrupt_stub_245
    dq interrupt_stub_246
    dq interrupt_stub_247
    dq interrupt_stub_248
    dq interrupt_stub_249
    dq interrupt_stub_250
    dq interrupt_stub_251
    dq interrupt_stub_252
    dq interrupt_stub_253
    dq interrupt_stub_254
    dq interrupt_stub_255
