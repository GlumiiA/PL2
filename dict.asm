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
    mov rax, [rsi]
    test rax, rax
    jz .not_found

    sub rsp, 8
    mov rdi, [rsi]
    call string_equals
    add rsp, 8

    cmp rax, 1
    je .found

    add rsi, 8
    jmp .loop

.found:
    mov rax, [rsi]
    pop rdi
    pop rsi
    ret

.not_found:
    xor rax, rax
    pop rdi
    pop rsi
    ret
