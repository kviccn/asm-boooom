#include "x86.h"

void readsect(void *dst, uint32_t offset);

void bootmain(void)
{
  readsect((void *)0x10000, 1);

  ((void (*)(void))(0x10000))();

  while (1)
    ;
}

void waitdisk(void)
{
  while ((inb(0x1F7) & 0xC0) != 0x40)
    ;
}

void readsect(void *dst, uint32_t offset)
{
  waitdisk();

  outb(0x1F2, 1);
  outb(0x1F3, offset);
  outb(0x1F4, offset >> 8);
  outb(0x1F5, offset >> 16);
  outb(0x1F6, (offset >> 24) | 0xE0);
  outb(0x1F7, 0x20);

  waitdisk();

  insl(0x1F0, dst, 512 / 4);
}
