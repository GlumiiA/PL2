NASMFLAGS = -f elf64 -g

.PHONY: clean
clean:
     rm -f *.o main

main: main.o lib.o dict.o
     ld -o $@ main.o lib.o dict.o

%.o: %.asm
     nasm $(NASMFLAGS) -o $@ $<

test: main
     python3 test.py