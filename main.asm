%include "dict.inc"
%include "words.inc"
%include "lib.inc"

%define BUF_SIZE 255
%define SYS_READ 0
%define STDIN 0
%define STDERR 2
%define SYS_WRITE 1

global _start

section .data

err_msg: db "Key not found", 10, 0

section .text

_start:
	sub rsp, BUF_SIZE				; выделение на стеке места под строку с stdin
	mov rax, SYS_READ
	mov rdi, STDIN
	mov rsi, rsp
	mov rdx, BUF_SIZE
	syscall
	
	mov byte [rsp + rax - 1], 0 	; заменяем '\n' в конце прочитанной строки на 0-терм
	
	mov rdi, rsp
	mov rsi, DICT_BEGIN
	call find_word					; поиск ключа в словаре
	
	test rax, rax
	jz .not_found
	
	mov r12, rax					; в r12 сохраняем адрес начала вхождения
	lea rdi, [rax + 8]
	call string_length				; вычисление длины ключа
	lea rdi, [r12 + 8 + rax + 1] 	; в rdi складываем значение по ключу
	call print_string
	xor rdi, rdi
	jmp .exit
	
.not_found:
	mov rdi, err_msg
	call string_length				; вычисление длины сообщения об ошибке
	mov rdx, rax
	
	mov rdi, STDERR
	mov rax, SYS_WRITE
	mov rsi, err_msg
	syscall
	
.exit: 
	add rsp, 255
	call exit

