#include "interrupts/idt.h"
#include "io/screen.h"
#include "io/serial/Serial.h"
#include "io/serial/SerialLog.h"
#include "memory/PMM.h"
#include "pic.h"
#include "stdint.h"

#define KERNEL_VIRTUAL_BASE 0xFFFFFFFF80000000
#define V2P(x) ((x) - KERNEL_VIRTUAL_BASE)

extern void _init_global_constructors();

extern "C" uint64_t _bss_end_addr[];

PMM pmm;
Serial serial;
Serial debugSerial(Serial::COM::COM2, Serial::BaudRate::BAUD_115200);

extern "C" void kernel_main(uint64_t multiboot_magic, uint64_t multiboot_addr) {
    _init_global_constructors(); // this is needed for global constructors

    serial.init();
    debugSerial.init();
    init_Log(&serial);

    if (multiboot_magic != 0x2BADB002) {
        LOG_ERROR("Invalid multiboor magic: 0x%x", multiboot_magic);
    }

    LOG_INFO("Multiboot Struct Pointer at: 0x%x", multiboot_addr);

    clear_screen();

    pic_remap();
    idt_init();

    serial.setCallback([](char c) {
        serial.print(&c, 1);
    });

    const char* test = "Hello World";
    LOG_INFO("%p", test);

    multiboot_info* info = (multiboot_info*)multiboot_addr;

    // pmm.init(info, KERNEL_VIRTUAL_BASE, (uint8_t*)_bss_end_addr);

    LOG_INFO("Memory initialized");

    while (true) {
        asm("hlt");
    }
}
