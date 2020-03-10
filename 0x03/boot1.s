.code16

.set DIVIDEND, 9527         # 被除数
.set DIVISOR, 10            # 除数
.set COUNT_OF_DIGITS, 4     # 位数 -- 分解需要的循环次数

movw $0x07c0, %ax
movw %ax, %ds

movw $0xb800, %ax
movw %ax, %es

# 设置 32位 被除数
# 高 16位 在 %dx 中, 低 16位 在 %ax 中
# 因为 %ax 足够保存 9527, 所以将高 16位(%dx) 清空
xorw %dx, %dx
movw $DIVIDEND, %ax
movw $DIVISOR, %bx
movw $COUNT_OF_DIGITS, %cx

# 初始化索引寄存器 (倒序保存各个数位)
movw $COUNT_OF_DIGITS - 1, %si
split:
  divw %bx
  # 除法指令执行后 商保存在 %ax 中, 余数保存在 %dx 中
  # 因为除数是 10, 所以余数小于 10, 即 %dl 中就是余数
  movb %dl, store(%si)
  xorw %dx, %dx
  decw %si
  loop split

movw $COUNT_OF_DIGITS, %cx
xorw %si, %si
xorw %di, %di
putc:
  movb store(%si), %al
  orw $0x0a30, %ax
  movw %ax, %es:(%di)
  incw %si
  addw $2, %di
  loop putc

jmp .

store:
  .byte 0, 0, 0, 0

.org 510
.word 0xAA55
