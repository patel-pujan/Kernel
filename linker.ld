ENTRY(_start)

MEMORY {
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 256K
    RAM (rwx) : ORIGIN = 0x40000000, LENGTH = 4M
}

SECTIONS {

    . = ORIGIN(RAM);

    .dtb (NOLOAD) : {
        PROVIDE(_dtb_start = .);
        . += 0x1000; /* resevere 4KB for DTB */
        PROVIDE(_dtb_end = .);
    } > RAM

    .text : { *(.text) } > RAM

    .data : { *(.data) } > RAM
    .bss : { *(.bss) } > RAM

    . = ORIGIN(RAM) + LENGTH(RAM);
    . = ALIGN(8);
    PROVIDE(_stack_top = .);
    . -= 0x1000;       /* 4KB stack */
    PROVIDE(_stack_bottom = .);
}
