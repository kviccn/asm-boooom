.code16

# 将初始光标位置读入 cx
movw $0x3d4, %dx
movb $0xe, %al
outb %al, %dx

movw $0x3d5, %dx
inb %dx, %al
movb %al, %ch

movw $0x3d4, %dx
movb $0xf, %al
outb %al, %dx

movw $0x3d5, %dx
inb %dx, %al
movb %al, %cl

# 设置光标位置为 0
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

jmp .

.org 510
.word 0xAA55
