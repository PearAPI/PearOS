#pragma once

#include <stdint.h>

// If your kernel doesn't have standard string.h, you might need to provide these
// or replace them with your kernel's kstrlen/kmemset.
#if defined(KERNEL_BUILD)
    // forward declare your kernel utils here if needed
    extern "C" size_t strlen(const char* str);
    extern "C" int strcmp(const char* s1, const char* s2);
#else
    #include <string.h>
    #include <stdio.h> // For snprintf in the client
#endif

namespace DebugProtocol {

// =============================================================
// 1. DEFINITIONS (Shared by Kernel and UI)
// =============================================================

enum CommandFlags : uint8_t {
    NONE      = 0,
    HAS_ADDR  = 1 << 0,
    HAS_VALUE = 1 << 1,
    HAS_COUNT = 1 << 2,
};

// X-Macro: The Single Source of Truth
#define COMMAND_LIST(X) \
    X(HELP,  "Displays this menu",   "[command]",       CommandFlags::NONE) \
    X(PEEK,  "Reads memory",         "<addr> [count]",  CommandFlags::HAS_ADDR | CommandFlags::HAS_COUNT) \
    X(POKE,  "Writes memory",        "<addr> <val>",    CommandFlags::HAS_ADDR | CommandFlags::HAS_VALUE) \
    X(DUMP,  "Dumps memory",         "<addr> <count>",  CommandFlags::HAS_ADDR | CommandFlags::HAS_COUNT) \
    X(STAT,  "Shows stats",          "",                CommandFlags::NONE) \
    X(INB,   "Reads I/O port",       "<port>",          CommandFlags::HAS_ADDR) \
    X(OUTB,  "Writes I/O port",      "<port> <val>",    CommandFlags::HAS_ADDR | CommandFlags::HAS_VALUE) \
    X(MMAP,  "Prints Memory Map",    "",                CommandFlags::NONE) \
    X(CREG,  "Creates register",     "<n> <a> <sz>",    CommandFlags::HAS_ADDR | CommandFlags::HAS_VALUE | CommandFlags::HAS_COUNT) \
    X(RESET, "Resets system",        "",                CommandFlags::NONE) \
    X(PING,  "Pings system",         "",                CommandFlags::NONE)

// 1. Generate Enum
enum class CommandType {
    UNKNOWN = 0,
#define X(name, desc, use, flags) name,
    COMMAND_LIST(X)
#undef X
    _COUNT
};

// 2. Generate Metadata Table
struct CommandDefinition {
    const char* name;
    const char* description;
    const char* usage;
    CommandType type;
    uint8_t flags;
};

static constexpr CommandDefinition COMMANDS[] = {
#define X(name, desc, use, flags) { #name, desc, use, CommandType::name, (uint8_t)(flags) },
    COMMAND_LIST(X)
#undef X
};

static constexpr size_t COMMAND_COUNT = sizeof(COMMANDS) / sizeof(COMMANDS[0]);

// The Result Struct (Zero Allocation)
struct DecodedCommand {
    CommandType type;
    uint64_t args[3]; // [0]=Addr, [1]=Value, [2]=Count (mapped by flags)
    bool isValid;
};

// =============================================================
// 2. IMPLEMENTATION (Inline for Header-Only)
// =============================================================

class Utils {
public:
    // Simple hex parser: "0x1234", "1234", "0X...", etc.
    static inline uint64_t ParseHex(const char* str, const char** outEnd = nullptr) {
        uint64_t result = 0;
        
        // Skip '0x' prefix if present
        if (str[0] == '0' && (str[1] == 'x' || str[1] == 'X')) {
            str += 2;
        }

        while (*str) {
            char c = *str;
            if (c >= '0' && c <= '9')      result = (result * 16) + (c - '0');
            else if (c >= 'a' && c <= 'f') result = (result * 16) + (c - 'a' + 10);
            else if (c >= 'A' && c <= 'F') result = (result * 16) + (c - 'A' + 10);
            else break; // Non-hex char
            str++;
        }
        
        if (outEnd) *outEnd = str;
        return result;
    }

    static inline bool StrEquals(const char* a, const char* b) {
        // Safe string compare
        if (!a || !b) return false;
        while (*a && *b) {
            if (*a != *b) return false;
            a++; b++;
        }
        // Both must be null terminator to be equal
        return (*a == '\0' && *b == '\0');
    }

    // Finds next token (skips spaces)
    static inline const char* NextToken(const char* str) {
        while (*str && (*str == ' ' || *str == '\t')) str++;
        return str;
    }

    // Finds end of current token
    static inline const char* EndToken(const char* str) {
        while (*str && *str != ' ' && *str != '\t' && *str != '\n' && *str != '\r') str++;
        return str;
    }
};

class Parser {
public:
    // This is the function your KERNEL will call
    static inline DecodedCommand Parse(const char* buffer) {
        DecodedCommand result = { CommandType::UNKNOWN, {0, 0, 0}, false };
        
        const char* ptr = Utils::NextToken(buffer);
        if (!*ptr) return result; // Empty string

        // 1. Identify Command
        const char* endCmd = Utils::EndToken(ptr);
        size_t cmdLen = endCmd - ptr;

        const CommandDefinition* def = nullptr;
        for (size_t i = 0; i < COMMAND_COUNT; i++) {
            // Manual strncasecmp logic could go here, for now using exact match
            // We verify length first to avoid prefix matching ("P" matching "PEEK")
            size_t nameLen = 0;
            while(COMMANDS[i].name[nameLen]) nameLen++;

            if (cmdLen == nameLen && strncmp(ptr, COMMANDS[i].name, cmdLen) == 0) {
                def = &COMMANDS[i];
                break;
            }
        }

        if (!def) return result; // Unknown command

        result.type = def->type;
        ptr = endCmd;

        // 2. Parse Arguments based on Flags
        // We map HAS_ADDR -> args[0], HAS_VALUE -> args[1], HAS_COUNT -> args[2]
        
        // Helper to parse one arg
        auto parseArg = [&](int index) {
            ptr = Utils::NextToken(ptr);
            if (!*ptr) return false; // Missing arg
            result.args[index] = Utils::ParseHex(ptr, &ptr);
            return true;
        };

        if (def->flags & CommandFlags::HAS_ADDR) {
            if (!parseArg(0)) return result; // Failed
        }
        if (def->flags & CommandFlags::HAS_VALUE) {
            if (!parseArg(1)) return result; 
        }
        if (def->flags & CommandFlags::HAS_COUNT) {
            if (!parseArg(2)) return result; 
        }

        result.isValid = true;
        return result;
    }
    
    // Helper to format a command back to string (For the CLIENT)
#ifndef KERNEL_BUILD
    static inline void Format(char* buffer, size_t size, CommandType type, uint64_t addr, uint64_t val, uint64_t count) {
        const CommandDefinition* def = nullptr;
        for(const auto& cmd : COMMANDS) if(cmd.type == type) def = &cmd;
        if(!def) return;

        // Start with Name
        int offset = snprintf(buffer, size, "%s", def->name);
        
        // Append Args
        if ((def->flags & HAS_ADDR) && offset < size) 
            offset += snprintf(buffer + offset, size - offset, " 0x%llX", addr);
            
        if ((def->flags & HAS_VALUE) && offset < size) 
            offset += snprintf(buffer + offset, size - offset, " 0x%llX", val);
            
        if ((def->flags & HAS_COUNT) && offset < size) 
            offset += snprintf(buffer + offset, size - offset, " 0x%llX", count);

        // Terminate
        if(offset < size) buffer[offset] = '\n';
        if(offset + 1 < size) buffer[offset+1] = '\0';
    }
#endif
};

} // namespace DebugProtocol