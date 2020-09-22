
CC=cc
CC_FLAGS=-Wall -ggdb3
CC_COMPILE_FLAGS=-fPIC -fpic -O3
CC_LINK_FLAGS=-lpthread

NASM=nasm
NASM_FLAGS=
NASM_COMPILE_FLAGS=-felf64

TARGET_BINARY=memcpy_bench

C_SOURCES=memcpy_bench.c libs/memcpy_multithread.c
NASM_SOURCES=libs/memcpy_avx256.asm libs/memcpy_avx512.asm libs/memcpy_movsb.asm

C_OBJECTS     = $(C_SOURCES:%.c=%.o)
NASM_OBJECTS += $(NASM_SOURCES:%.asm=%.o)

ALL_OBJECTS   = $(C_OBJECTS)
ALL_OBJECTS  += $(NASM_OBJECTS)

all: $(TARGET_BINARY)

$(C_OBJECTS): $(C_SOURCES)
	$(CC) $(CC_FLAGS) $(CC_COMPILE_FLAGS) -c $(@:%.o=%.c) -o $(@) $(CC_LINK_FLAGS)

$(NASM_OBJECTS): $(NASM_SOURCES)
	$(NASM) $(NASM_FLAGS) $(NASM_COMPILE_FLAGS) $(@:%.o=%.asm) -o $(@)

$(TARGET_BINARY): $(C_OBJECTS) $(NASM_OBJECTS)
	$(CC) $(CC_FLAGS) $(C_OBJECTS) $(NASM_OBJECTS) -o $(@) $(CC_LINK_FLAGS)

clean:
	rm -vf $(TARGET_BINARY) $(ALL_OBJECTS)

