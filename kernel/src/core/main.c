#define asm(x) __asm__ __volatile__(x)


void kernel_main() {
    char* video_memory = (char*) 0xb8000;

    *video_memory = 'X';

    asm("hlt");
}