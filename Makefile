ASM=nasm

main:
	[ -d out ] || mkdir out
	$(ASM) src/boot.asm -f bin -o out/boot.bin
