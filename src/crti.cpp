#include "stdint.h"

// These symbols are defined by the Linker Script
extern "C" {
typedef void (*constructor_func_t)();
extern constructor_func_t __init_array_start[];
extern constructor_func_t __init_array_end[];
}

// Call this function ONCE at the very top of kernel_main
void _init_global_constructors() {
    // Calculate the number of constructors
    // Pointers arithmetic: (end - start) gives the count
    size_t count = __init_array_end - __init_array_start;

    for (size_t i = 0; i < count; i++) {
        // Get the function pointer
        constructor_func_t constructor = __init_array_start[i];

        // Call the constructor
        constructor();
    }
}