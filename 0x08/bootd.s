.code16

xorw %ax, %ax
movw $0x7c00, %sp

callw get_cursor

jmp .

# 目的: 获取光标位置
#
# 输入: 无
#
# 输出: 光标当前位置, 保存在 %ax 中
get_cursor:
  movw $0x3d4, %dx
  movb $0xe, %al
  outb %al, %dx

  movw $0x3d5, %dx
  inb %dx, %al
  movb %al, %ah

  movw $0x3d4, %dx
  movb $0xf, %al
  outb %al, %dx

  movw $0x3d5, %dx
  inb %dx, %al

  retw

.org 510
.word 0xAA55
