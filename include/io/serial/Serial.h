#pragma once

#include "stdint.h"
#include <stdarg.h>

class Serial {
  public:
    enum class COM : uint16_t {
        COM1 = 0x3F8,
        COM2 = 0x2F8,
        COM3 = 0x3E8,
        COM4 = 0x2E8,
        COM5 = 0x3D8,
        COM6 = 0x2D8,
        COM7 = 0x3C8,
        COM8 = 0x2C8,
    };

    enum class BaudRate : uint8_t {
        BAUD_115200 = 1,
        BAUD_57600 = 2,
        BAUD_38400 = 3,
        BAUD_19200 = 6,
        BAUD_9600 = 12,
    };

    enum class LineCoding : uint8_t {
        DATA_8_BIT = 0x03,
        DATA_7_BIT = 0x02,
    };

    enum class FlowControl : uint8_t {
        NONE = 0x00,
        RTS_CTS = 0x01,
    };

    enum class Parity : uint8_t {
        NONE = 0b000,
        ODD = 0b001,
        EVEN = 0b011,
        MARK = 0b101,
        SPACE = 0b111,
    };

    enum class StopBits : uint8_t {
        ONE = 0x00,
        ONE_AND_ONE_HALF = 0x01,
    };

    enum class DataBits : uint8_t {
        FIVE = 0x00,
        SIX = 0x01,
        SEVEN = 0x02,
        EIGHT = 0x03,
    };

    Serial(COM com = COM::COM1, BaudRate baudRate = BaudRate::BAUD_115200,
           LineCoding lineCoding = LineCoding::DATA_8_BIT,
           FlowControl flowControl = FlowControl::NONE);

    void init();

    bool isDataAvailable();

    void println(const char* str, size_t len);
    void print(const char* str, size_t len);
    void printf(const char* format, ...);
    void vprintf(const char* format, va_list args);

    char readChar();

    using SerialCallback = void (*)(char);
    void setCallback(SerialCallback callback);

  private:
    inline static const uint8_t DATA_OFFSET = 0;
    inline static const uint8_t INTERRUPT_REGISTER_OFFSET = 1;
    inline static const uint8_t LSB_DIVISOR_BAUD_RATE_OFFSET = 0;
    inline static const uint8_t MSB_DIVISOR_BAUD_RATE_OFFSET = 1;
    inline static const uint8_t INTERRUPT_IDENTIFICATION_REGISTER_OFFSET = 2;
    inline static const uint8_t LINE_CONTROL_REGISTER_OFFSET = 3;
    inline static const uint8_t MODEM_CONTROL_REGISTER_OFFSET = 4;
    inline static const uint8_t LINE_STATUS_REGISTER_OFFSET = 5;
    inline static const uint8_t MODEM_STATUS_REGISTER_OFFSET = 6;
    inline static const uint8_t SCRATCH_REGISTER_OFFSET = 7;

    COM comPort;
    BaudRate baudRate;
    LineCoding lineCoding;
    FlowControl flowControl;

    SerialCallback dataCallback = nullptr;

    static void interrupt_handler(struct CPUContext* context);

    void enableFIFO();
    void setBaud(BaudRate baudRate);
    void setLineCoding(LineCoding lineCoding);
    void setFlowControl(FlowControl flowControl);

    void setDLAB();
    void clearDLAB();

    void wait();
};
