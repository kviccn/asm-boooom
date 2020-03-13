%.bin: %.o
	objcopy -O binary -j .text $< $@

%.o: %.s
	as --32 $< -o $@

%.dump: %.bin
	objdump -D -b binary -m i386 -Mi8086,suffix $<

%.o.dump: %.o
	objdump -D -t -m i386 -Mi8086,suffix $<

%.qemu: %.bin
	DISPLAY=:0 qemu-system-i386 $<

# 禁止删除中间文件
.PRECIOUS: %.bin %.o

clean:
	rm -f *.bin *.o
