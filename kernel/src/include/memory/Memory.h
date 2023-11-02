#include <memory/paging/Paging.h>
#include <types.h>

#define MEMORY_KERNEL_HEAP_START 0x1000000 // 1 GiB
#define MEMORY_KERNEL_HEAP_SIZE 0x1000000 // 1 GiB

/*
    start: The start address of the memory range
    size: The size of the memory range in bytes
    flags: The flags of the memory range

    The flags are as follows:
        ___________________
        | U R W E X U X X |
        -------------------

        U - Used
        R - Readable
        W - Writable
        E - Executable
        M - Mode (0 = Kernel, 1 = User)
        X - Reserved
*/

typedef struct {
    uintptr_t start; // 8 bytes
    uint64_t size; // 8 bytes
    uint8_t flags; // 1 byte
} MemoryRange_t;

#define MEMORY_FLAG_MASK_USED 0x80
#define MEMORY_FLAG_MASK_READABLE 0x40
#define MEMORY_FLAG_MASK_WRITABLE 0x20
#define MEMORY_FLAG_MASK_EXECUTABLE 0x10
#define MEMORY_FLAG_MASK_ZEROED 0x08
#define MEMORY_FLAG_MASK_MODE 0x04


#define MAX_MEMORY_RANGES 1024
#define ALIGNMENT_BOUNDARY 16 // 16 bytes

#define ALIGN(x) (((x) + ALIGNMENT_BOUNDARY - 1) & ~(ALIGNMENT_BOUNDARY - 1))

#define OFSET_NEXT_Range(x) ((x->start + x->size_low + ((uint64_t)x->size_high << 32)))

uintptr_t malloc(uint64_t size);
void free(uintptr_t address);