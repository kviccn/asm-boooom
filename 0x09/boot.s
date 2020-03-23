.code16

.set INT_TYPE_CODE, 0x70
.set INT_HANDLER_BASE, 0x07c0

movw $0xb800, %ax
movw %ax, %es

movw $0x7c00, %sp

# 安装中断向量表
call install_ivt

# 触发中断
int $INT_TYPE_CODE

jmp .

install_ivt:
  movw $INT_TYPE_CODE, %bx
  shlw $2, %bx

  movw $handler, (%bx)
  movw $INT_HANDLER_BASE, 2(%bx)

  ret

# 中断处理程序
handler:
  movw $'8' | 0x0a00, %es:0
  iret

.org 510
.word 0xAA55
