NASMFLAGS = -f elf64 -g

main: main.o lib.o dict.o
	ld -o main  main.o lib.o dict.o

main.o: main.asm
	nasm $(NASMFLAGS) -o main.o main.asm

lib.o: lib.asm
	nasm $(NASMFLAGS) -o lib.o lib.asm

dict.o: dict.asm
	nasm $(NASMFLAGS) -o dict.o dict.asm

test: main
	python3 test.py

.PHONY: clean
clean:
	rm -f *.o main
