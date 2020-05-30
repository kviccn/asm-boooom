%.bin: %.o
	ld -e start -Ttext=0x7c00 -m elf_i386 --oformat binary $< -o $@

%.o: %.S
	cc -m32 -c -o $@ $<

%.dump: %.bin
	objdump -D -b binary -m i386 -Mi8086,suffix $<

%.qemu: %.bin
	DISPLAY=:0 qemu-system-i386 -drive file=$<,format=raw -monitor stdio

# 禁止删除中间文件
.PRECIOUS: %.bin %.o

clean:
	rm -f *.bin *.o
