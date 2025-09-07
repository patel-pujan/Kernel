.section .text          // code section
.global _start
.type _start, @function

.extern kernel
.extern _stack_top

_start:

  LDR x0, =_stack_top   // load stack_top into x0
  MOV SP, x0            // set SP to stack_top

  LDR x1, =_deadbeef    // load address of DEADBEEF into x1
  LDR x1, [x1]          // load DEADBEEF into x1

  BL kernel             // branch & link to C kernel
  B .                   // loop continuously

.section .data          // initialized data section
_deadbeef:
.quad 0xDEADBEEF

.section .bss           // uninitialized data section
