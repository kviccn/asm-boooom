.code16

movw $0x07c0, %ax
movw %ax, %ds

xorw %ax, %ax
movw $0x7c00, %sp

callw clear_screen

pushw $0
callw set_cursor
addw $2, %sp

pushw $message
callw puts
addw $2, %sp

jmp .

# 目的: 打印字符串
#
# 输入:
#   参数1 字符串在数据段的索引
#
# 输出: 无
puts:
  pushw %bp
  movw %sp, %bp

  pushw %bx
  pushw %si
  movw 4(%bp), %si

1:
  cmpb $0, (%si)
  je .ps_exit
  movb (%si), %bl
  andw $0x00ff, %bx
  orw $0x0a00, %bx
  pushw %bx
  callw putc
  addw $2, %sp
  incw %si
  jmp 1b

.ps_exit:
  popw %si
  popw %bx

  movw %bp, %sp
  popw %bp
  retw

# 目的: 打印字符
#
# 输入:
#   参数1 字符（可包含显示属性）
#
# 输出: 无
putc:
  pushw %bp
  movw %sp, %bp

  pushw %cx
  pushw %es
  pushw %si

  movw 4(%bp), %cx

  movw $0xb800, %ax
  movw %ax, %es

  callw get_cursor
  movw %ax, %si
  shlw $1, %si

  movw %cx, %es:(%si)

  incw %ax
  pushw %ax
  callw set_cursor
  addw $2, %sp

  popw %si
  popw %es
  popw %cx

  movw %bp, %sp
  popw %bp
  retw

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

# 目的: 清空屏幕
#
# 输入: 无
#
# 输出: 无
clear_screen:
  pushw %bp
  movw %sp, %bp

  pushw %es
  pushw %si
  pushw %cx

  movw $0xb800, %cx
  movw %cx, %es

  movw $2000, %cx
  xorw %si, %si
1:
  movw $' ' | 0x0700, %es:(%si)
  addw $2, %si
  loop 1b

  popw %cx
  popw %si
  popw %es

  movw %bp, %sp
  popw %bp
  retw

message:
  .asciz "laoli ai ni!"

.org 510
.word 0xAA55
