.code16

movw $0x07c0, %ax
movw %ax, %ds

movw $0xb800, %ax
movw %ax, %es

xorw %si, %si
movw message_length, %cx

l1:
  movb message(%si), %bl
  movb %bl, %es:(%si)
  incw %si
  loop l1

jmp .

message:
  .byte 'H', 0xa, 'e', 0xa, 'l', 0xa, 'l', 0xa, 'o', 0xa, ' ', 0xa, 'W', 0xa, 'o', 0xa, 'r', 0xa, 'l', 0xa, 'd', 0xa
message_length:
  .word . - message

.org 510
.word 0xAA55
