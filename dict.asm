%include "lib.inc"

section .text

global find_word

; В rdi - адрес нуль-терминированной строки
; В rsi - адрес начала словаря
find_word:
    push rsi
    push rdi
    
.loop:
    mov rax, [rsi]
    test rax, rax
    jz .not_found

    push rax
    mov rdi, rax
    call string_equals
    pop rax

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
