boot.img: boot kernel
	dd if=/dev/zero of=boot.img bs=512 count=2
	dd if=boot of=boot.img conv=notrunc
	dd if=kernel of=boot.img seek=1 conv=notrunc

boot: boot.o main.o sign
	ld -N -e start -Ttext=0x7c00 -m elf_i386 -o $@.elf boot.o main.o
	objdump -S $@.elf >$@.asm
	objcopy -S -O binary -j .text $@.elf $@.bin
	cp $@.bin $@
	./sign $@

%.o: %.c
	cc -m32 -fno-builtin -fno-pic -nostdinc -c -o $@ $<

boot.o: boot.S
	cc -m32 -c -o $@ $<

kernel: kernel.o
	objdump -S $< >$@.asm
	objcopy -S -O binary -j .text $< $@

qemu: boot.img
	DISPLAY=:0 qemu-system-i386 -drive file=$<,format=raw -monitor stdio

sign: ../0x00/sign.c
	cc $< -o $@

clean:
	rm -f kernel boot sign *.img *.elf *.bin *.o *.asm
