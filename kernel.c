#include <stdint.h>

extern uint8_t _dtb_start;
volatile uint8_t *uart = (uint8_t *)0x09000000;

void uart_putc(char c) { *uart = c; }

void kernel(void) {
  uint8_t *dtb = &_dtb_start;

  while (*dtb != '\n') {
    uart_putc(*dtb);
    dtb++;
  }

  while (1) {
  }
}
