boot.bin: boot.o
	objcopy -O binary -j .text boot.o boot.bin

boot.o: boot.s
	as --32 boot.s -o boot.o

dump.bin: boot.bin
	objdump -D -b binary -m i386 -Mi8086,suffix boot.bin

dump.o: boot.o
	objdump -D -m i386 -Mi8086,suffix boot.o

qemu: boot.bin
	DISPLAY=:0 qemu-system-i386 boot.bin

clean:
	rm -rf boot.bin boot.o
