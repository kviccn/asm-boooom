# $ echo "set auto-load safe-path /" >> ~/.gdbinit

target remote localhost:1234
set architecture i8086
set tdesc filename target.xml
display/i $cs*16+$pc
b *0x7c00
c
