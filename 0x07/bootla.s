.code16

movw $0x7c00, %sp

lcallw $0x07d0, $0

jmp .

.org 0x100
put_char_A:
  movw $0xb800, %ax
  movw %ax, %es
  movw $'A' | 0x0a00, %es:0
  lretw

.org 510
.word 0xAA55
