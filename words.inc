%include "colon.inc"

section .data

colon "first", first
db "simple text", 0

colon "second", second
db "на русском", 0

colon "third", third
db "third         word", 0

colon "", empty
db "key is empty", 0
