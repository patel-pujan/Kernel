.section .text
.global _start
.type _start, %function

.extern kernel

_start:
    
    LDR x0, =stack_top  // load stack_top into x0
    MOV SP, x0          // move set SP to stack_top

    MSR DAIFSet, #0xf   // disable IRQ, FIQ, SError, Debug exceptions

    BL kernel           // branch and link to C Kernel

    B .                 // Loop Continuously

.section .bss
.global stack_top
    .align 12           // align to 4096 (2^12) bytes
    .space 4096         // allocate 4096 bytes
stack_top:
