bits 64

section .text
extern stack_top
extern kernel_main
global start64

start64:
    mov rsp, stack_top

    call kernel_main
    hlt