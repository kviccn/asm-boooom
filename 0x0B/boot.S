# filename - boot.S

#include "mmu.h"

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

  movb $'L', 0xb8000
  movb $0x0a,0xb8001

  movb $'a', 0xb8002
  movb $0x0a,0xb8003

  movb $'o', 0xb8004
  movb $0x0a,0xb8005

  movb $'l', 0xb8006
  movb $0x0a,0xb8007

  movb $'i', 0xb8008
  movb $0x0a,0xb8009

hlt

.p2align 2
gdt:
  SEG_NULL
  SEG(STA_X | STA_R, 0x0, 0xffffffff)
  SEG(STA_W, 0x0, 0xffffffff)

gdtdesc:
  .word gdtdesc - gdt - 1
  .long gdt

.org 510
.word 0xAA55
