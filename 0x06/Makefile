%.img: %.bin message.data
	dd if=/dev/zero of=$@ bs=512 count=2
	dd if=$< of=$@ conv=notrunc
	dd if=message.data of=$@ seek=1 conv=notrunc

%.bin: %.o
	objcopy -O binary -j .text $< $@

%.o: %.s
	as --32 $< -o $@

%.dump: %.bin
	objdump -D -b binary -m i386 -Mi8086,suffix $<

%.o.dump: %.o
	objdump -D -t -m i386 -Mi8086,suffix $<

%.qemu: %.img
	DISPLAY=:0 qemu-system-i386 -drive file=$<,format=raw

message.data:
	echo 'A' >> message.data

# 禁止删除中间文件
.PRECIOUS: %.img %.bin %.o

clean:
	rm -f *.img *.bin *.o
