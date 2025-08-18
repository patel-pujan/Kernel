#include <stdint.h>

volatile uint8_t *uart = (uint8_t *)0x09000000;

void putChar(char c) { *uart = c; }

void print(const char *str) {
  while (*str != '\n') {
    putChar(*str);
    str++;
  }
}

void kernel(void) {
  print("Hello World");
  while (1) {
  }
}
