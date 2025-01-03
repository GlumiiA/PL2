%include "lib.inc"

section .text
global find_word

find_word:
    ; Сохраняем регистры
    push rdi
    push rsi
    push rdx

.loop:
    ; Проверяем, не нулевой ли указатель на текущий элемент
    test rsi, rsi
    jz .not_found

    ; Вызываем функцию сравнения строк
    sub rsp, 8   ; Выравниваем стек перед вызовом
    lea rdi, [rsi]  ; Указываем на текущий элемент
    call string_equals
    add rsp, 8   ; Восстанавливаем стек

    ; Проверяем результат сравнения
    cmp rax, 1   ; Проверяем, равно ли возвращаемое значение единице
    je .found

    ; Если не найдено, переходим к следующему элементу
    mov rsi, [rsi] ; Получаем адрес следующего элемента
    jmp .loop

.found:
    ; Если найдено, восстанавливаем регистры и возвращаем адрес
    pop rdx
    pop rsi
    pop rdi
    mov rax, rdi ; Возвращаем адрес найденного слова
    ret

.not_found:
    ; Восстанавливаем регистры и возвращаем 0, если слово не найдено
    pop rdx
    pop rsi
    pop rdi
    xor rax, rax ; Устанавливаем rax в 0
    ret
