.code16

movw $0xb800, %ax
movw %ax, %ds

xorw %ax, %ax
movw %ax, %ss

movw $0x7c00, %sp

pushw $'c' | 0x0a00
pushw $'b' | 0x0a00
pushw $'a' | 0x0a00

popw 0
popw 2
popw 4

jmp .

.org 510
.word 0xAA55
