.code16

movw $0x07c0, %ax
movw %ax, %ds

movw $0x7c00, %sp

lcallw *procedure_address

jmp .

.org 0x100
put_char_A:
  movw $0xb800, %ax
  movw %ax, %es
  movw $'A' | 0x0a00, %es:0
  lretw

procedure_address:
  # 偏移地址, 段地址
  .word 0, 0x07d0

.org 510
.word 0xAA55
