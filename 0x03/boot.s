.code16

movw $0x07c0, %ax
movw %ax, %ds

movw $0xb800, %ax
movw %ax, %es

cld
movw $message, %si
xorw %di, %di
movw message_length, %cx
rep movsb

jmp .

message:
  .byte 'H', 0xa, 'e', 0xa, 'l', 0xa, 'l', 0xa, 'o', 0xa, ' ', 0xa, 'W', 0xa, 'o', 0xa, 'r', 0xa, 'l', 0xa, 'd', 0xa
message_length:
  .word . - message

.org 510
.word 0xAA55
