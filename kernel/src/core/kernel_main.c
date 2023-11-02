#include <types.h>
#include <gdt.h>
#include <memory/paging/Paging.h>
#include <memory/Memory.h>

#define asm(x) __asm__ __volatile__(x)

uint64_t video_memory_offset = 0;

void print(char* str) {
    char* video_memory = (char*) 0xb8000 + video_memory_offset * 2;
    for (int i = 0; str[i] != '\0'; i++) {
        *video_memory = str[i];
        video_memory += 2;
        video_memory_offset++;
    }
}

char* int_to_hex(uint64_t n) {
    char* res = "0000000000000000";
    int i = 15;
    while (n > 0) {
        int rem = n % 16;
        if (rem < 10) {
            res[i] = rem + '0';
        } else {
            res[i] = rem - 10 + 'A';
        }
        n /= 16;
        i--;
    }
    return res;
}

void kernel_main() {
    asm("cli");

    // init_gdt();

    char* mem_test = (char*) malloc(100);

    // fill mem_test with 0x42
    for (int i = 0; i < 100; i++) {
        mem_test[i] = 0x42;
    }

    print(int_to_hex(mem_test));

    asm("hlt");
}