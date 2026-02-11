#include "io/serial/SerialLog.h"
#include "io/serial/Serial.h"

static Serial* serial = nullptr;

void init_Log(Serial* s) { serial = s; }

const char* levelToString(LogLevel level) {
    switch (level) {
    case LogLevel::INFO:
        return "INFO";
    case LogLevel::WARNING:
        return "WARN";
    case LogLevel::ERROR:
        return "ERR ";
    case LogLevel::DEBUG:
        return "DBUG";
    default:
        return "UNKN";
    }
}

void logf(LogLevel level, const char* file, int line, const char* format, ...) {
    serial->write("[");
    const char* levelStr = levelToString(level);
    size_t len = 0;
    while (levelStr[len] != '\0')
        len++;
    serial->write(levelStr);
    serial->write("] ");
    serial->write(" (");
    serial->printf("%s : %d", file, line);
    serial->write(") ");

    va_list args;
    va_start(args, format);
    serial->vprintf(format, args);
    va_end(args);

    serial->write("\n");
}
