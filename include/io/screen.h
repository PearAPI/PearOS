#pragma once
#include "stdint.h"

enum CONSTANTS {
    VGA_WIDTH = 80,
    VGA_HEIGHT = 25
};

enum Colors {
    BLACK = 0x00,
    BLUE = 0x01,
    GREEN = 0x02,
    CYAN = 0x03,
    RED = 0x04,
    MAGENTA = 0x05,
    BROWN = 0x06,
    LIGHT_GRAY = 0x07,
    DARK_GRAY = 0x08,
    LIGHT_BLUE = 0x09,
    LIGHT_GREEN = 0x0A,
    LIGHT_CYAN = 0x0B,
    LIGHT_RED = 0x0C,
    LIGHT_MAGENTA = 0x0D,
    YELLOW = 0x0E,
    WHITE = 0x0F
};

void clear_screen();
void screen_put_char(char c);
void screen_print(const char *str);
void set_foreground_color(uint8_t color);
void set_background_color(uint8_t color);
void set_cursor_position(uint8_t x, uint8_t y);
void printf(const char *str, ...);
void println(const char *str);