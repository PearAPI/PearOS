#include <memory/Memory.h>

MemoryRange_t memoryRanges[MAX_MEMORY_RANGES];

uintptr_t malloc(uint64_t size) {
    size_t offset = MEMORY_KERNEL_HEAP_START;
    // Find a free memory range
    for(size_t index = 0; index < MAX_MEMORY_RANGES; index++) {
        // Get the current memory range
        MemoryRange_t* range = (MemoryRange_t*) offset;

        // Check if the range is free
        if(!(range->flags & MEMORY_FLAG_MASK_USED)) {
            range->start = offset;
            range->size = size;
            range->flags = MEMORY_FLAG_MASK_USED;
            return range->start + sizeof(MemoryRange_t);
        }

        // Add the size of the range to the offset
        offset += range->size;
    }
}



void free(uintptr_t address) {
    MemoryRange_t* range = (MemoryRange_t*) (address - sizeof(MemoryRange_t));


    range->flags &= ~MEMORY_FLAG_MASK_USED;
}