%include "lib.inc"

section .text

global find_word

; Принимает два аргумента: указатель на нуль-терминированную строку и указатель на начало словаря.
; Пройдёт по всему словарю в поисках подходящего ключа. 
; Если подходящее вхождение найдено, вернёт адрес начала вхождения в словарь (не значения), иначе вернёт 0.
find_word: 
	test rsi, rsi
	jz .end					; если не найдено, в rax сложим значение rsi - исходя из test, оно равно 0
	
	push rsi
	push rdi
	add rsi, 8
	sub rsp, 8				; выравнивание стека
	call string_equals
	add rsp, 8
	pop rdi
	pop rsi					; тут восстанавливается предыдущее значение rsi (без прибавления 8)
							; т.е. адрес начала вхождения в словарь (не значения)
	test rax, rax
	jnz .end
	
	mov rsi, [rsi]
	jmp find_word
	
.end: 
	mov rax, rsi			 
	ret

	
.end: 
	mov rax, rsi			 
	ret

