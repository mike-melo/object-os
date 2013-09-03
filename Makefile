
all:
	../nasm-2.10.09/nasm -f bin -o build/kernel.bin src/kernel.asm
	cp build/base.img build/kernel.img
	dd if=build/kernel.bin of=build/kernel.img conv=notrunc

init: create-dirs basegen

create-dirs:
	mkdir build

basegen:
	dd if=/dev/zero of=base.img bs=512 count=2880
	mv base.img build/

clean:
	rm -rf build/
