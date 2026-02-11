#pragma once

#include "RingBuffer.h"
#include <stdarg.h>
#include <stdint.h>

// Forward declaration for your interrupt system
struct CPUContext;

class Serial {
  public:
    enum class COM : uint16_t {
        COM1 = 0x3F8,
        COM2 = 0x2F8,
        COM3 = 0x3E8,
        COM4 = 0x2E8
    };

    Serial(COM port = COM::COM1);

    // Initialization
    void init();

    // The Main API
    char read();        // Returns next char from RX Buffer
    void write(char c); // Pushes char to TX Buffer (starts sending)
    void write(const char* str);
    bool available(); // Do we have data to read?

    // Polling Fallback (Bypasses buffers)
    void writeSync(char c);

    // Formatted Output
    void printf(const char* fmt, ...);
    void vprintf(const char* fmt, va_list args);

    using SerialCallback = void (*)(char);

    // 2. Add the method to set it
    void setCallback(SerialCallback callback);

  private:
    // --- Hardware Registers ---
    static const uint16_t DATA_REG = 0;    // R/W
    static const uint16_t INT_ENABLE = 1;  // R/W (IER)
    static const uint16_t FIFO_CTRL = 2;   // W (FCR)
    static const uint16_t INT_IDENT = 2;   // R (IIR)
    static const uint16_t LINE_CTRL = 3;   // R/W (LCR)
    static const uint16_t MODEM_CTRL = 4;  // R/W (MCR)
    static const uint16_t LINE_STATUS = 5; // R (LSR)

    // --- Callback ---
    SerialCallback dataCallback;

    static Serial* irq4_instance;
    static Serial* irq3_instance;

    // --- State ---
    COM port;
    bool initialized = false;

    // --- Buffers (1KB each) ---
    // Make sure these are large enough for your debug data!
    RingBuffer<char, 1024> rxBuffer;
    RingBuffer<char, 1024> txBuffer;

    // --- Internal Helpers ---
    void setBaud(uint16_t divisor);
    void configureLine();

    // Helper to kickstart the TX interrupt if it went to sleep
    void startTransmission();

    // --- Interrupt Handling ---
    static Serial* instance; // Pointer to the active serial object
    static void interrupt_handler(CPUContext* ctx);
};