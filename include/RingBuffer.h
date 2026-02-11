#pragma once
#include <stdint.h>

template <typename T, size_t Size>
class RingBuffer {
  public:
    void push(T data) {
        if (isFull())
            return; // Drop data if full (or handle error)
        buffer[head] = data;
        head = (head + 1) % Size;
        count++;
    }

    T pop() {
        if (isEmpty())
            return T();
        T val = buffer[tail];
        tail = (tail + 1) % Size;
        count--;
        return val;
    }

    bool isEmpty() const { return count == 0; }
    bool isFull() const { return count == Size; }
    size_t available() const { return count; }

  private:
    volatile T buffer[Size];
    volatile size_t head = 0;
    volatile size_t tail = 0;
    volatile size_t count = 0;
};