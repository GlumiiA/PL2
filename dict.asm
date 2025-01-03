%include "lib.inc"
section .text
global find_word

find_word:

.loop:
    push rdi
    push rsi
    add rsi, 8  ; pointer to null-terminated string in rdi, beginning of dictionary in rsi
    sub rsp, 8
    call string_equals 
    add rsp, 8
    pop rsi
    pop rdi
    cmp rax, 1
    je .found
    mov rsi, [rsi] ; load the address of the next string in the dictionary -> rsi
    cmp rsi, 0 ; 0 is the edn of dictionary
    je .not_found
    jmp .loop

.found:
    sub rsp, 8
    call string_length 
    add rsp, 8
    add rax, rsi
    add rax, 9 ; 8 for the next character and 1 for null terminator
    ret

.not_found:
    mov rax, 0
    ret
