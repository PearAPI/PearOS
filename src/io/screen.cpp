#include "io/screen.h"
#include "stdarg.h"
#include "stdint.h"

volatile uint16_t* vga_buffer = (volatile uint16_t*)0xB8000;

uint16_t cursor_position = 0;

uint8_t foreground_color = 0x07;
uint8_t background_color = 0x00;

static void scroll() {
    // Determine the amount of characters to move back (one line)
    uint16_t lines_to_move = (VGA_HEIGHT - 1) * VGA_WIDTH;

    // Move the memory back
    for (int i = 0; i < lines_to_move; i++) {
        vga_buffer[i] = vga_buffer[i + VGA_WIDTH];
    }

    // Clear the last line
    uint16_t attribute = (background_color << 4) | (foreground_color & 0x0F);
    uint16_t empty = 0x20 | (attribute << 8);
    for (int i = lines_to_move; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        vga_buffer[i] = empty;
    }

    cursor_position -= VGA_WIDTH;
}

void screen_put_char(char c) {
    if (c == '\n') {
        cursor_position += VGA_WIDTH;
        cursor_position -= cursor_position % VGA_WIDTH;
    } else {
        uint16_t attribute =
            (background_color << 4) | (foreground_color & 0x0F);
        vga_buffer[cursor_position] = c | (attribute << 8);
        cursor_position++;
    }

    if (cursor_position >= VGA_WIDTH * VGA_HEIGHT) {
        scroll();
    }
}

void clear_screen() {
    uint16_t attribute = (background_color << 4) | (foreground_color & 0x0F);
    uint16_t empty = 0x20 | (attribute << 8);

    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        vga_buffer[i] = empty;
    }
    cursor_position = 0;
}

void set_foreground_color(uint8_t color) { foreground_color = color; }

void set_background_color(uint8_t color) { background_color = color; }

void set_cursor_position(uint8_t x, uint8_t y) {
    cursor_position = y * VGA_WIDTH + x;
}

void screen_print(const char* str) {
    for (int i = 0; str[i] != '\0'; i++) {
        screen_put_char(str[i]);
    }
}

void println(const char* str) {
    screen_print(str);
    screen_put_char('\n');
}

// Helper for printf to print a number
static void print_number(int64_t num, int base) {
    char buf[32];
    int i = 0;
    int is_negative = 0;

    if (num == 0) {
        screen_put_char('0');
        return;
    }

    // Handle negative numbers for base 10
    if (num < 0 && base == 10) {
        is_negative = 1;
        num = -num;
    }

    // Handle unsigned for hex by casting if needed, but for simplicity here
    // treating as int If exact unsigned behavior is needed we should probably
    // pass unsigned int to a helper
    uint64_t unum = (uint64_t)num;

    while (unum > 0) {
        int digit = unum % base;
        if (digit < 10)
            buf[i++] = digit + '0';
        else
            buf[i++] = digit - 10 + 'A';
        unum /= base;
    }

    if (is_negative) {
        screen_put_char('-');
    }

    while (i > 0) {
        screen_put_char(buf[--i]);
    }
}

void print_pointer(void* ptr) {
    screen_print("0x");
    print_number((int64_t)ptr, 16);
}

void printf(const char* str, ...) {
    va_list args;
    va_start(args, str);

    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] == '%') {
            i++;
            switch (str[i]) {
            case 'c': {
                char c = (char)va_arg(args, int);
                screen_put_char(c);
                break;
            }
            case 's': {
                const char* s = va_arg(args, const char*);
                screen_print(s);
                break;
            }
            case 'd':
            case 'i': {
                int d = va_arg(args, int);
                print_number(d, 10);
                break;
            }
            case 'x':
            case 'X': {
                int x = va_arg(args, int);
                screen_print("0x");
                print_number(x, 16);
                break;
            }
            case 'p': {
                void* p = va_arg(args, void*);
                print_pointer(p);
                break;
            }
            case '%': {
                screen_put_char('%');
                break;
            }
            default: {
                screen_put_char('%');
                screen_put_char(str[i]);
                break;
            }
            }
        } else {
            screen_put_char(str[i]);
        }
    }

    va_end(args);
}
