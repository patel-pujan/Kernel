ARCH ?= aarch64
TOOLPREFIX ?= $(ARCH)-elf-

# Tools
CC := $(TOOLPREFIX)gcc
LD := $(TOOLPREFIX)ld
AS := $(TOOLPREFIX)as
OBJDUMP := $(TOOLPREFIX)objdump
QEMU := qemu-system-aarch64

# Flags
CFLAGS := -ffreestanding -O0 -Wall -Wextra
ASFLAGS :=
LDFLAGS := -nostdlib -T linker.ld
QEMUFLAGS := -machine virt -cpu cortex-a57 -nographic

# Files
SRC_C := kernel.c
SRC_ASM := boot.S
OBJ := $(SRC_C:.c=.o) $(SRC_ASM:.S=.o)
TARGET := kernel.elf

# Default target
all: $(TARGET)

# Compile C files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble assembly files
%.o: %.S
	$(AS) $(ASFLAGS) -c $< -o $@

# Link
$(TARGET): $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $(OBJ)

# Optional: disassemble for inspection
disasm: $(TARGET)
	$(OBJDUMP) -d $(TARGET) > disasm.txt

clean:
	rm -f $(OBJ) $(TARGET) disasm.txt

run:
	$(QEMU) $(QEMUFLAGS) -kernel $(TARGET)

.PHONY: all disasm clean run
