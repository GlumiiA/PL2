%include "lib.inc"
section .text
global find_word

; Принимает два аргумента:
; Указатель на нуль-терминированную строку.
; Указатель на начало словаря.
; Пройдёт по всему словарю в поисках подходящего ключа. Если подходящее вхождение найдено, вернёт 
; адрес начала вхождения в словарь (не значения), иначе вернёт 0.
find_word:
sub rsp, 8 ; выравниваем стек
.loop
    push rdi ; 16
    push rsi ; 8
    test rsi, rsi
    jz .end
    lea rsi, [rsi+8]
    call string_equals
    pop rsi
    pop rdi
    cmp rax, 1 
    je .end ; значит нашли нужный ключ и можно выходить
    mov rsi, [rsi] ; адрес следущего элемента
    jmp .loop
.end
    add rsp, 8
    mov rax, rsi
    ret
.out
    add rsp, 8
    xor rax, rax
    ret
