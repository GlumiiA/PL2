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
.loop:
    push rdi 
    push rsi 

    test rsi, rsi ; 
    jz .out 

    lea rsi, [rsi + 8] ; получаем адрес следующего элемента
    call string_equals 

    pop rsi 
    pop rdi 

    cmp rax, 1 ; проверяем результат
    je .end ; если нашли ключ, переходим к .end

    mov rsi, [rsi] ; переходим к следующему элементу
    jmp .loop 

.end:
    add rsp, 8 
    mov rax, rsi 
    ret

.out:
    add rsp, 8 ; восстанавливаем стек
    xor rax, rax 
    ret
