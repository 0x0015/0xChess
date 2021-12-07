OBJS = main.o \
       uci.o \
       chess.o \
       time.o

OUT = main

BUILD_FLAGS = -felf64 -Fstabs
BUILD_FLAGS_WIN = -fwin64
LINK_OPTS = -dynamic-linker /lib64/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o -lc
LINK_OPTS_EXTRA = /usr/lib/x86_64-linux-gnu/crtn.o

all: $(OBJS)
	ld -o $(OUT) $(LINK_OPTS) $(OBJS) $(LINK_OPTS_EXTRA)

%.o: %.asm
	nasm $(BUILD_FLAGS) -o $@ $<

%.c.o: %.c
	gcc -c -g -o $@ $<

clean:
	rm -f $(OBJS) $(OUT)

.PHONEY: clean
