#!/usr/bin/env python3
import os

print("Generating interrupt stubs...")

# contains first 32 hardware IRQs
# if the irq pushes an error code, the value is true, otherwise false.abs
# used later on, to determain if a dummy error code should be pushed
hardware_IRQs = [
    (0, False, "Divide-by-zero Error"),
    (1, False, "Debug"),
    (2, False, "Non-maskable Interrupt"),
    (3, False, "Breakpoint"),
    (4, False, "Overflow"),
    (5, False, "BOUND Range Exceeded"),
    (6, False, "Invalid Opcode"),
    (7, False, "Device Not Available"),
    (8, True, "Double Fault"),
    (9, False, "Coprocessor Segment Overrun"),
    (10, True, "Invalid TSS"),
    (11, True, "Segment Not Present"),
    (12, True, "Stack Fault"),
    (13, True, "General Protection Fault"),
    (14, True, "Page Fault"),
    (15, False, "x87 FPU Floating-Point Error"),
    (16, False, "Alignment Check"),
    (17, False, "Machine Check"),
    (18, False, "SIMD Floating-Point Exception"),
    (19, False, "Virtualization Exception"),
    (20, False, "Control Protection Exception"),
    (21, False, "Reserved"),
    (22, False, "Reserved"),
    (23, False, "Reserved"),
    (24, False, "Reserved"),
    (25, False, "Reserved"),
    (26, False, "Reserved"),
    (27, False, "Reserved"),
    (28, False, "Hypervisor Injection Exception"),
    (29, False, "VMM Communication Exception"),
    (30, False, "Security Exception"),
    (31, False, "Reserved"),
]


stub_template_noerror = """
interrupt_stub_{}:
    push 0                  ; 1. Push Dummy Error
    push {}                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. CRITICAL: Pass stack pointer to C++
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq
"""

stub_template_error = """
interrupt_stub_{}:
                            ; 1. Error Code already pushed by CPU
    push {}                 ; 2. Push Interrupt Number
    push_all                ; 3. Push Registers
    
    mov rdi, rsp            ; 4. Pass stack pointer
    call interrupt_handler
    
    pop_all                 ; 5. Restore Registers
    add rsp, 16             ; 6. Remove Int Num & Error Code
    iretq
"""

# check if output file already exists
if os.path.exists("src/interrupts/interrupts.asm"):
    os.remove("src/interrupts/interrupts.asm")



macros_file = open("scripts/genIRQStubs_assets/macros.txt", "r")
header_file = open("scripts/genIRQStubs_assets/header.txt", "r")
out_file = open("src/interrupts/interrupts.asm", "w")

out_file.write(header_file.read())
out_file.write(macros_file.read())

for i in range(0, 256):
    if(i < 32):
        if(hardware_IRQs[i][1]):
            out_file.write(stub_template_error.format(i, i, hardware_IRQs[i][2], hardware_IRQs[i][0]))
        else:
            out_file.write(stub_template_noerror.format(i, i, hardware_IRQs[i][2], hardware_IRQs[i][0]))
    else:
        out_file.write(stub_template_noerror.format(i, i, "User Defined", i))

out_file.write("\nsection .data\n")
out_file.write("global isr_stub_table\n")
out_file.write("isr_stub_table:\n")

for i in range(0, 256):
    out_file.write("    dq interrupt_stub_{}\n".format(i))

macros_file.close()
out_file.close()