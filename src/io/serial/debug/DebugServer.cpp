#include "io/serial/debug/DebugServer.h"
#include "io/io.h" // For inb/outb
#include "io/serial/SerialLog.h"

Serial* DebugServer::pSerial = nullptr;
char DebugServer::cmdBuffer[128];
size_t DebugServer::cmdIndex = 0;

void DebugServer::Init(Serial& serial) {
    pSerial = &serial;
    // Register our callback!
    pSerial->setCallback(OnSerialData);
}

void DebugServer::OnSerialData(char c) {
    // 1. Handle Backspace (Convenience for manual typing)
    if (c == '\b' || c == 0x7F) {
        if (cmdIndex > 0) {
            cmdIndex--;
            // Optional: Echo backspace to clean terminal
            // pSerial->write("\b \b");
        }
        return;
    }

    // 2. Handle Newline -> Execute
    if (c == '\n' || c == '\r') {
        if (cmdIndex > 0) {
            cmdBuffer[cmdIndex] = '\0';
            ProcessCommand(cmdBuffer);
            cmdIndex = 0;
        }
    } else {
        // 3. Accumulate
        if (cmdIndex < sizeof(cmdBuffer) - 1) {
            cmdBuffer[cmdIndex++] = c;
        }
    }
}

void DebugServer::ProcessCommand(const char* line) {
    using namespace DebugProtocol;

    // 1. Parse
    auto cmd = Parser::Parse(line);

    LOG_INFO("Received command: %s", line);

    if (!cmd.isValid) {
        // Protocol error (maybe send a log?)
        return;
    }

    // 2. Execute
    switch (cmd.type) {
    case CommandType::PING:
        SendReply(cmd.token, "OK", "PONG");
        break;

    case CommandType::PEEK: {
        // ARGS[0] = Address, ARGS[2] = Count (Flags: HAS_ADDR | HAS_COUNT)
        uint64_t addr = cmd.args[0];

        // TODO: Add `IsAddressValid(addr)` check here to avoid Page Faults!

        // Read 64-bit value
        uint64_t val = *(volatile uint64_t*)addr;
        SendReply(cmd.token, "OK", "0x%llX", val);
        break;
    }

    case CommandType::POKE: {
        // ARGS[0] = Addr, ARGS[1] = Value
        uint64_t* ptr = (uint64_t*)cmd.args[0];
        *ptr = cmd.args[1];
        SendReply(cmd.token, "OK", nullptr);
        break;
    }

    case CommandType::INB: {
        uint16_t port = (uint16_t)cmd.args[0];
        uint8_t val = inb(port);
        SendReply(cmd.token, "OK", "0x%X", val);
        break;
    }

    case CommandType::OUTB: {
        uint16_t port = (uint16_t)cmd.args[0];
        uint8_t val = (uint8_t)cmd.args[1];
        outb(port, val);
        SendReply(cmd.token, "OK", nullptr);
        break;
    }

    default:
        SendReply(cmd.token, "ERR", "Unknown Command");
        break;
    }
}

void DebugServer::SendReply(uint32_t token, const char* status, const char* dataFmt, ...) {
    if (!pSerial)
        return;

    // 1. Send Header: "CMD <TOKEN> <STATUS>"
    // Note: We don't have the CMD name easily available here unless we pass it,
    // but the client mainly cares about Token matching.
    // Usually, simply echoing "RPLY <TOKEN> <STATUS>" is enough.

    pSerial->printf("RPLY %u %s", token, status);

    // 2. Send Data (if any)
    if (dataFmt) {
        pSerial->write(" "); // Separator

        va_list args;
        va_start(args, dataFmt);
        pSerial->vprintf(dataFmt, args);
        va_end(args);
    }

    // 3. Terminate
    pSerial->write("\n");
}