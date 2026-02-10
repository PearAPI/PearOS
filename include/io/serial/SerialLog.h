#pragma once

#include "Serial.h"

enum class LogLevel : uint8_t {
    INFO = 0,
    WARNING,
    ERROR,
    DEBUG,
};

void init_Log(Serial* serial);

void logf(LogLevel level, const char* file, int line, const char* format, ...);

#define LOG_INFO(format, ...) logf(LogLevel::INFO, __FILE__, __LINE__, format, ##__VA_ARGS__)
#define LOG_WARNING(format, ...) logf(LogLevel::WARNING, __FILE__, __LINE__, format, ##__VA_ARGS__)
#define LOG_ERROR(format, ...) logf(LogLevel::ERROR, __FILE__, __LINE__, format, ##__VA_ARGS__)
#define LOG_DEBUG(format, ...) logf(LogLevel::DEBUG, __FILE__, __LINE__, format, ##__VA_ARGS__)