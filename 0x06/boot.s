.code16

movw $0x1000, %ax
movw %ax, %es

xorw %di, %di

movw $0x1f2, %dx
movb $1, %al
outb %al, %dx

movw $0x1f3, %dx
movb $1, %al
outb %al, %dx

movw $0x1f4, %dx
movb $0, %al
outb %al, %dx

movw $0x1f5, %dx
movb $0, %al
outb %al, %dx

movw $0x1f6, %dx
movb $0, %al
orb  $0xe0, %al     # b'1110xxxx' LBA 主硬盘
outb %al, %dx

movw $0x1f7, %dx
movb $0x20, %al     # 读硬盘
outb %al, %dx

.wait:              # 等待硬盘不忙且准备好数据
  inb %dx, %al
  andb $0x88, %al
  cmpb $0x08, %al
  jnz .wait

movw $256, %cx
movw $0x1f0, %dx
rep insw

movw $0xb800, %ax
movw %ax, %ds

movw %es:0, %ax
movw %ax, 0

jmp .

.org 510
.word 0xAA55
