NASMFLAGS = -f elf64 -g

.PHONY: clean
clean:
	rm -f *.o main

%.o: %.asm
	nasm $(NASMFLAGS) -o $@ $<

main: main.o lib.o dict.o
	ld -o $@ main.o lib.o dict.o

test: main
	python3 test.py
