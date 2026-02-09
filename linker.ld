ENTRY(_start)

MEMORY {
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 256K
    /* RAM (rw) : ORIGIN = 0x40000000, LENGTH = 4M */
    USEABLE_RAM (rw) : ORIGIN = 0x40010000, LENGTH = 4M
}

SECTIONS {

    . = ORIGIN(USEABLE_RAM);

    /* .text : { *(.text) } > FLASH */
    .text : { *(.text) } > FLASH AT > USEABLE_RAM
    .data : { *(.data) } > USEABLE_RAM
    .bss : { *(.bss) } > USEABLE_RAM

    . = ORIGIN(USEABLE_RAM) + LENGTH(USEABLE_RAM);
    . = ALIGN(8);
    PROVIDE(_stack_top = .);
    . -= 0x1000;       /* 4KB stack */
    PROVIDE(_stack_bottom = .);
}
