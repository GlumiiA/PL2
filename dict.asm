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

    ; Проверяем, не нулевой ли указатель на текущий элемент
    test rsi, rsi
    jz .found

    lea rsi, [rsi + 8]
    sub rsp, 8
    call string_equals
    add rsp, 8
    pop rsi
    pop rdi
    ; Если строки равны, возвращаем адрес найденного слова
    cmp rax, 1
    je .found
.not_found:
    ; переходим к следующему элементу в словаре
    mov rsi, [rsi]
    test rsi, rsi
    jnz find_word
    xor rax, rax
    ret
.found:
    mov rax, rsi ; Возвращаем адрес найденного слова
    ret
