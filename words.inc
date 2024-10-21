%include "colon.inc"

section .data

colon "", empty_key
db "empty data", 0

colon "second", second
db "second word", 0

colon "third", third
db "third word", 0

colon " ", space_test
db "space_test word", 10, 0
