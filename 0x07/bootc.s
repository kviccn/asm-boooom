.code16

movw $0x07c0, %ax
movw %ax, %ds

movw $0x7c00, %sp

callw *procedure_address

jmp .

put_char_A:
  movw $0xb800, %ax
  movw %ax, %es
  movw $'A' | 0x0a00, %es:0
  retw

procedure_address:
  .word 0x7c00 + put_char_A

.org 510
.word 0xAA55
