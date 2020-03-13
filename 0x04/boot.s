.code16

.set DIVIDEND, 9527         # 被除数
.set DIVISOR, 10            # 除数

movw $0x07c0, %ax
movw %ax, %ds

movw $0xb800, %ax
movw %ax, %es

xorw %ax, %ax
movw %ax, %ss

movw $0x7c00, %sp

# 设置 32位 被除数
# 高 16位 在 %dx 中, 低 16位 在 %ax 中
# 因为 %ax 足够保存 9527, 所以将高 16位(%dx) 清空
xorw %dx, %dx
movw $DIVIDEND, %ax
movw $DIVISOR, %bx

# 分解位数的同时统计一共有多少位
# 显示的时候需要用位数控制循环次数
xorw %cx, %cx
split:
  incw %cx
  divw %bx
  orw $0xa30, %dx
  pushw %dx
  xorw %dx, %dx
  cmpw $0, %ax      # 商为零则分解完毕, 不为零则继续分解
  jne split

xorw %si, %si
putc:
  popw %es:(%si)
  addw $2, %si
  loop putc

jmp .

.org 510
.word 0xAA55
