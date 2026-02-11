#include "interrupts/idt.h"
#include "io/screen.h"
#include "io/serial/Debug/DebugServer.h"
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
Serial debugSerial(Serial::COM::COM1);
Serial logSerial(Serial::COM::COM2);

DebugServer debugServer;

extern "C" void kernel_main(uint64_t multiboot_magic, uint64_t multiboot_addr) {
    _init_global_constructors(); // this is needed for global constructors

    clear_screen();

    pic_remap();
    idt_init();

    debugSerial.init();
    logSerial.init();

    // init_Log(&serial);
    debugServer.Init(debugSerial);

    debugSerial.printf("Hello World %d %x %p %c %s\n", 123, 0x123, &debugSerial, 'a', "Hello World");

    if (multiboot_magic != 0x2BADB002) {
        LOG_ERROR("Invalid multiboor magic: 0x%x", multiboot_magic);
    }

    multiboot_info* info = (multiboot_info*)multiboot_addr;

    // pmm.init(info, KERNEL_VIRTUAL_BASE, (uint8_t*)_bss_end_addr);

    LOG_INFO("Memory initialized");

    while (true) {
        asm("hlt");
    }
}
