os:
	rm *.bin
	nasm -f bin ../Bootloader/16BitsBootloader.asm -o TealOSBootloader.bin
	nasm -f bin ../Kernel/Kernel.asm -o TealOSKernel.bin
	cat TealOSBootloader.bin TealOSKernel.bin > TealOS.flp
	-cd Emulators && rm *.flp
	mv TealOS.flp Emulators