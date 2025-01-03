%include "lib.inc"

section .text

global find_word

; Принимает два аргумента:
; Указатель на нуль-терминированную строку.
; Указатель на начало словаря.
; Пройдёт по всему словарю в поисках подходящего ключа. Если подходящее вхождение найдено, вернёт
; адрес начала вхождения в словарь (не значения), иначе вернёт 0.
find_word:
    push rdi
    push rsi

    test rsi, rsi
    jz .out

    lea rsi, [rsi + 8]

    sub rsp, 8
    call string_equals
    add rsp, 8

    cmp rax, 1  
    je .found

    pop rsi
    pop rdi
    mov rsi, [rsi]
    test rsi, rsi
    jnz find_word
    jmp .out

.found:
    mov rax, rsi
    ret

.out:
    pop rsi
    pop rdi    
    xor rax, rax
    ret

