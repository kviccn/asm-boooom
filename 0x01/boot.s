.code16

movw $0xb800, %ax
movw %ax, %es

movb $'H', %es:0
movb $0xa, %es:1

jmp .

.org 510
.word 0xAA55
