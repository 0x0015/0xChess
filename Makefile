OBJS = main.o

OUT = main

BUILD_FLAGS = -felf64
BUILD_FLAGS_WIN = -f win64
LINK_OPTS = -dynamic-linker /lib64/ld-linux-x86-64.so.2 /usr/lib64/crt1.o /usr/lib64/crti.o -lc
LINK_OPTS_EXTRA = /usr/lib64/crtn.o

all: $(OBJS)
	ld -o $(OUT) $(LINK_OPTS) $(OBJS) $(LINK_OPTS_EXTRA)

%.o: %.asm
	nasm $(BUILD_FLAGS) -o $@ $<

clean:
	rm -f $(OBJS) $(OUT)

.PHONEY: clean
