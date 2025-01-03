%include "lib.inc"
%include "words.inc"
%include "dict.inc"

global _start

section .rodata
prompt: db "Введите ключ:", `\n`, "> ", 0
bof_message: db "Ошибка: введённый ключ должен быть длиной не более 255 символов", `\n`, 0
not_found_message: db "Ключ не найден", `\n`, 0

%define dict_start first_word

section .text

_start:
    mov rdi, prompt
    sub rsp, 8
    call print_string
    add rsp, 8
    
    sub rsp, 256
    mov rdi, rsp
    mov rsi, 256
    sub rsp, 8
    call read_line
    add rsp, 8
    test rax, rax
    jz .bof

    push rdx
    mov rsi, dict_start
    mov rdi, rax
    call find_word
    test rax, rax
    jz .fail

    .success:

    pop rdi
    lea rdi, [rdi + rax + 9]
    sub rsp, 8
    call print_string
    call print_newline
    add rsp, 8
    xor rdi, rdi
    call exit

    .fail:
    mov rdi, not_found_message
    sub rsp, 8
    call print_string
    add rsp, 8
    xor rdi, rdi
    call exit

    .bof:
    mov rdi, bof_message
    sub rsp, 8
    call print_err
    add rsp, 8
    mov rdi, -1
    call exit
