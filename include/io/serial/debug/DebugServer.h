#pragma once
#define KERNEL_BUILD
#include "io/serial/Serial.h"
#include "protocol.h"

class DebugServer {
  public:
    // Initialize with the serial port instance
    static void Init(Serial& serial);

    // The callback we pass to Serial::setCallback
    static void OnSerialData(char c);

  private:
    static Serial* pSerial;

    // Command Accumulator
    static char cmdBuffer[128];
    static size_t cmdIndex;

    // Execution Logic
    static void ProcessCommand(const char* line);
    static void SendReply(uint32_t token, const char* status, const char* dataFmt = nullptr, ...);
};