.code16

movw $0x7c00, %sp

callw set_cursor

jmp .

# 目的: 设置光标位置为 0
#
# 输入: 无
#
# 输出: 无
set_cursor:
  movw $0x3d4, %dx
  movb $0xe, %al
  outb %al, %dx

  movw $0x3d5, %dx
  movb $0, %al
  outb %al, %dx

  movw $0x3d4, %dx
  movb $0xf, %al
  outb %al, %dx

  movw $0x3d5, %dx
  movb $0, %al
  outb %al, %dx

  retw

.org 510
.word 0xAA55
