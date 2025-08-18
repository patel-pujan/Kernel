.section .text          // code section
.global _start
.type _start, @function

.extern kernel
.extern _stack_top

_start:

    LDR x0, =_stack_top // load stack_top into x0
    MOV SP, x0          // set SP to stack_top

    MSR DAIFSet, #0xf   // disable IRQ, FIQ, SError, Debug exceptions

    BL kernel           // branch and link to C Kernel

    B .                 // loop continuously

.section .data          // initialized data section

.section .bss           // uninitialized data section
