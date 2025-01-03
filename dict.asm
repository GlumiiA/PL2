%include "lib.inc"

section .text

global find_word

; Принимает два аргумента:
; Указатель на нуль-терминированную строку.
; Указатель на начало словаря.
; Пройдёт по всему словарю в поисках подходящего ключа. Если подходящее вхождение найдено, вернёт
; адрес начала вхождения в словарь (не значения), иначе вернёт 0.
find_word:
    push rsi
    push rdi
    
.loop:
    test rsi, rsi
    jz .not_found

    lea rsi, [rsi + 8]
    call string_equals

    cmp rax, 1
    je .found

    jmp .loop

.found:
    mov rax, rsi
    pop rdi
    pop rsi
    ret

.not_found:
    xor rax, rax
    pop rdi
    pop rsi
    ret
