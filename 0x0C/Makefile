boot: boot.o main.o sign
	ld -N -e start -Ttext=0x7c00 -m elf_i386 -o $@.elf boot.o main.o
	objdump -S $@.elf >$@.asm
	objcopy -S -O binary -j .text -j .rodata $@.elf $@.bin
	cp $@.bin $@
	./sign $@

main.o: main.c
	cc -m32 -fno-builtin -fno-pic -nostdinc -c -o $@ $<

boot.o: boot.S
	cc -m32 -c -o $@ $<

dump: boot.bin
	objdump -D -b binary -m i386 -Mi8086,suffix $<

qemu: boot
	DISPLAY=:0 qemu-system-i386 -drive file=$<,format=raw -monitor stdio

sign: ../0x00/sign.c
	cc $< -o $@

clean:
	rm -f boot sign *.elf *.bin *.o *.asm
