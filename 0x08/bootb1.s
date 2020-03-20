.code16

movw $0x7c00, %sp

pushw $79
callw set_cursor
addw $2, %sp

jmp .

# 目的: 设置光标位置
#
# 输入:
#   参数1 光标所在位置
#
# 输出: 无
set_cursor:
  pushw %bp
  movw %sp, %bp

  movw $0x3d4, %dx
  movb $0xe, %al
  outb %al, %dx

  movw $0x3d5, %dx
  movb 5(%bp), %al
  outb %al, %dx

  movw $0x3d4, %dx
  movb $0xf, %al
  outb %al, %dx

  movw $0x3d5, %dx
  movb 4(%bp), %al
  outb %al, %dx

  movw %bp, %sp
  popw %bp

  retw

.org 510
.word 0xAA55
