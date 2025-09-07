ARCH ?= aarch64
TOOLPREFIX ?= $(ARCH)-elf-

# Tools
CC       := $(TOOLPREFIX)gcc
LD       := $(TOOLPREFIX)ld
AS       := $(TOOLPREFIX)as
OBJDUMP  := $(TOOLPREFIX)objdump
OBJCOPY  := $(TOOLPREFIX)objcopy
QEMU     := qemu-system-$(ARCH)

# Flags
CFLAGS     := -g -ffreestanding -O0 -Wall -Wextra
ASFLAGS    := -g
LDFLAGS    := -nostdlib -T linker.ld
DUMPFLAGS  := -dS
COPYFLAGS  := -O binary
QEMUFLAGS  := -machine virt-10.1 -cpu cortex-a57 -nographic

# Files
SRC_C    := kernel.c
OBJ_C    := $(SRC_C:.c=.o)
SRC_ASM  := boot.S
OBJ_ASM  := $(SRC_ASM:.S=.o)
OBJS     := $(OBJ_C) $(OBJ_ASM)
TARGET   := kernel.elf

# Debug
DEBUG_TARGET  ?= $(TARGET)


# Default target
all: $(TARGET)

# Compile C files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble assembly files
%.o: %.S
	$(AS) $(ASFLAGS) -c $< -o $@

# Link
$(TARGET): $(OBJS) linker.ld
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

# Optional:
disasm: $(DEBUG_TARGET)
	$(OBJDUMP) $(DUMPFLAGS) $(DEBUG_TARGET)

assem: $(DEBUG_TARGET)
	$(AS) $(ASFLAGS) $(DEBUG_TARGET)

clean:
	rm -f $(OBJS) $(ELF) $(TARGET)

run:
	$(QEMU) $(QEMUFLAGS) -kernel $(TARGET)

.PHONY: all disasm clean run
