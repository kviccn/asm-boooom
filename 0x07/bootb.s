.code16

movw $0x7c00, %sp

movw $0x7c00 + put_char_A, %cx

callw *%cx

jmp .

put_char_A:
  movw $0xb800, %ax
  movw %ax, %es
  movw $'A' | 0x0a00, %es:0
  retw

.org 510
.word 0xAA55
