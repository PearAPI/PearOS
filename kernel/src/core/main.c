#define asm(x) __asm__ __volatile__(x)


void kernel_main() {
    asm("hlt");
}