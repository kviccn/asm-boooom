.code16

.set INT_TYPE_CODE, 0x08
.set INT_HANDLER_BASE, 0x07c0
.set _8259A_MASTER, 0x20

movw $0xb800, %ax
movw %ax, %es

movw $0x7c00, %sp

xorw %si, %si

# 安装中断向量表
call install_ivt

# 初始化 8259a
# 使用默认配置

sleep:
  hlt
  jmp sleep

install_ivt:
  movw $INT_TYPE_CODE, %bx
  shlw $2, %bx

  movw $handler, (%bx)
  movw $INT_HANDLER_BASE, 2(%bx)

  ret

handler:
  movw $'8' | 0x0a00, %es:(%si)
  addw $2, %si

  # send eoi
  movb $0x20, %al
  outb %al, $_8259A_MASTER

  iret

.org 510
.word 0xAA55
