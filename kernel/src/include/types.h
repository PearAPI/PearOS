#pragma once

#define ofsetof(type, member) ((size_t) &((type *)0)->member)

//
// Type definitions
//
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

typedef char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long long int64_t;

typedef uint64_t size_t;
typedef uint64_t uintptr_t;

typedef int64_t ssize_t;