%include "lib.inc"

section .text

global find_word

; В rdi - адрес нуль-терминированной строки
; В rsi - адрес начала словаря
find_word:
push rdi
push rsi
lea rsi, [rsi + 8]
sub rsp, 8
call string_equals
add rsp, 8
pop rsi
pop rdi
cmp rax, 1
jne .skip
mov rax, rsi
ret
.skip:
mov rsi, [rsi]
test rsi, rsi
jnz find_word
xor rax, rax
ret
