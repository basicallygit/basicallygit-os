ASM=nasm

main:
	$(ASM) src/boot.asm -f bin -o out/boot.bin
