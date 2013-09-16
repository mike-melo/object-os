
all: clean init build-kernel launch

link-modules:
	cat src/header.asm src/modules/*.asm src/tail.asm > build/kernel.asm

build-source: link-modules
	../nasm-2.10.09/nasm -f bin -o build/kernel.bin build/kernel.asm

build-kernel: build-source
	cp build/base.img build/kernel.img
	dd if=build/kernel.bin of=build/kernel.img conv=notrunc

launch:
	-VBoxManage controlvm ObjectOS poweroff
	VirtualBox --dbg -startvm ObjectOS &

init: create-dirs basegen

create-dirs:
	mkdir build

basegen:
	dd if=/dev/zero of=base.img bs=512 count=2880
	mv base.img build/

clean:
	rm -rf build/
