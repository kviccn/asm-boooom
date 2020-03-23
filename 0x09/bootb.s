.code16

.set INT_TYPE_CODE, 0x20
.set INT_HANDLER_BASE, 0x07c0
.set _8259A_MASTER, 0x20
.set _8259A_SLAVE, 0xa0

movw $0xb800, %ax
movw %ax, %es

movw $0x7c00, %sp

xorw %si, %si

# 安装中断向量表
call install_ivt

# 初始化 8259a
call init_8259a

sleep:
  hlt
  jmp sleep

install_ivt:
  movw $INT_TYPE_CODE, %bx
  shlw $2, %bx

  movw $handler, (%bx)
  movw $INT_HANDLER_BASE, 2(%bx)

  ret

init_8259a:
  movb 0x11, %al
  outb %al, $_8259A_MASTER
  outb %al, $_8259A_SLAVE

  movb $0x20, %al
  outb %al, $_8259A_MASTER + 1
  movb $0x28, %al
  outb %al, $_8259A_SLAVE + 1

  movb $0x04, %al
  outb %al, $_8259A_MASTER + 1
  movb $0x02, %al
  outb %al, $_8259A_SLAVE + 1

  movb $0x01, %al
  outb %al, $_8259A_MASTER + 1
  outb %al, $_8259A_SLAVE + 1

  movb $0x0, %al
  outb %al, $_8259A_MASTER + 1
  outb %al, $_8259A_SLAVE + 1

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
