section .rodata
%include "words.inc"
%include "lib.inc"
%include "dict.inc"

%define SIZE_BUFFER 256 ; Читает строку размером не более 255 символов + нуль-терминант
%define STDIN 0
%define SYS_READ 0

section .data
message_error_find: db "dictionary entry not found", `\n`, 0
message_error_read: db "string is empty", `\n`, 0
message_hello: db "Hello! Enter the key: ", `\n`, 0

section .text

global _start

_start:
;Читает строку размером не более 255 символов в буфер с stdin.
; Пытается найти вхождение в словаре; если оно найдено, распечатывает в stdout значение по этому ключу.
; Иначе выдает сообщение об ошибке.
mov rdi, message_hello
sub rsp, 8
call print_string
add rsp, 8

.reading:
    sub rsp, SIZE_BUFFER ; выделения места на стеке для строки
    mov rdi, rsp
    mov rsi, SIZE_BUFFER
    sub rsp, 8 ; выравниваем стек
    call read_string
    add rsp, 8
    
    test rax, rax
    jz .not_find
    
    lea r13, [rax - 1]
    mov rdi, rsp ; Указатель на нуль-терминированную строку.
    mov rsi, DICT_BEGIN ; Указатель на начало словаря.
    call find_word
    test rax, rax ; если не нашёл
    jz .not_find
.print_string:
    lea rdi, [r13 + rax + 8 + 1]
    ; значение по ключю в rdi
    call print_string
    jmp .exit
.not_read:
    mov rdi, message_error_read
    call print_err
    jmp .exit
.not_find:
    mov rdi, message_error_find
    call print_err
.exit:
    add rsp, 8
    add rsp, SIZE_BUFFER
    xor rdi, rdi
    call exit
