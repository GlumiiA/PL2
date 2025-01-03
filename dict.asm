%include "lib.inc"
section .text
global find_word

; Принимает два аргумента:
; Указатель на нуль-терминированную строку.
; Указатель на начало словаря.
; Пройдёт по всему словарю в поисках подходящего ключа. Если подходящее вхождение найдено, вернёт
; адрес начала вхождения в словарь (не значения), иначе вернёт 0.
find_word:
    ; Выравниваем стек
    sub rsp, 8
    
    ; Сохраняем регистры
    push rdi
    push rsi
    push rdx
    
.loop:
    ; Проверяем, не нулевой ли указатель на текущий элемент
    test rsi, rsi
    jz .out

    mov rdx, rsi

    lea rsi, [rsi + 8]

    call string_equals
    ; Если строки равны, возвращаем адрес найденного слова
    cmp rax, 1  
    je .found

    ; Если не найдено, продолжаем искать
    mov rsi, [rdx] ; Переходим к следующему элементу в словаре
    jmp .loop

.found:
    pop rdx
    pop rsi
    pop rdi
    
    mov rax, rdx ; Возвращаем адрес найденного слова
    add rsp, 8   
    ret

.out:
    pop rdx
    pop rsi
    pop rdi
    
    mov rax, 0  ; Возвращаем 0 при отсутствии слова
    add rsp, 8 
    ret
