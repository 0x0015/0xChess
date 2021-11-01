OBJS = main.o \
       uci.o \
       chess.o \
       time.c.o

OUT = main

BUILD_FLAGS = -felf64 -Fstabs
BUILD_FLAGS_WIN = -fwin64
LINK_OPTS = -dynamic-linker /lib64/ld-linux-x86-64.so.2 /usr/lib64/crt1.o /usr/lib64/crti.o -lc
LINK_OPTS_EXTRA = /usr/lib64/crtn.o

all: $(OBJS)
	ld -o $(OUT) $(LINK_OPTS) $(OBJS) $(LINK_OPTS_EXTRA)

%.o: %.asm
	nasm $(BUILD_FLAGS) -o $@ $<

%.c.o: %.c
	gcc -c -g -o $@ $<

clean:
	rm -f $(OBJS) $(OUT)

.PHONEY: clean
