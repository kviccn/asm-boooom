.set PROT_MODE_CSEG, 0x08        # code segment selector
.set PROT_MODE_DSEG, 0x10        # data segment selector

.globl start
start:
  .code16
  cli

  # Enable A20
  inb $0x92, %al
  orb $0x2, %al
  outb %al, $0x92

  # Load GDT
  lgdt gdtdesc
  
  # Switch from real to protected mode
  movl %cr0, %eax
  orl $0x1, %eax
  movl %eax, %cr0

  # Jump into 32-bit protected mode
  ljmp $PROT_MODE_CSEG, $protcseg

  .code32
protcseg:
  movw $PROT_MODE_DSEG, %ax
  movw %ax, %ds

  movb $'L', 0
  movb $0x0a,1

  movb $'a', 2
  movb $0x0a,3

  movb $'o', 4
  movb $0x0a,5

  movb $'l', 6
  movb $0x0a,7

  movb $'i', 8
  movb $0x0a,9

hlt

.p2align 2
gdt:
  .quad 0x0
  .quad 0x00cf98000000ffff
  .quad 0x0040920b8000ffff

gdtdesc:
  .word gdtdesc - gdt - 1
  .long gdt

.org 510
.word 0xAA55
