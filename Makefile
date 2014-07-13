all: clean init build-kernel launch

check-for-test:
ifndef test
	$(error 'test' is undefined)
endif

check-for-module:
ifndef module
	$(error 'module' is undefined)
endif

test-target:
	for dep in $(deps); do \
	   fulldeps+=src/modules/$$dep.asm" "; \
	done; \
	echo $$fulldeps;
	
link-tests: check-for-test check-for-module
	for dep in $(deps); do \
	   fulldeps+=src/modules/$$dep.asm" "; \
	done; \
	cat src/std.mac src/test/fixture.asm src/test/$(test)-test.asm src/modules/$(module).asm $$fulldeps > build/kernel.asm

build-tests: link-tests 
	../nasm-2.10.09/nasm -f bin -o build/kernel.bin build/kernel.asm

build-tests-kernel: build-tests build-boot link-kernel-and-boot
	cp build/base.img build/kernel.img
	dd if=build/boot-kernel.bin of=build/kernel.img conv=notrunc

launch-tests: build-tests-kernel launch


link-modules:
	cat src/std.mac src/header.asm src/modules/*.asm > build/kernel.asm

build-source: link-modules
	../nasm-2.10.09/nasm -f bin -o build/kernel.bin build/kernel.asm

build-boot:
	../nasm-2.10.09/nasm -f bin -o build/boot.bin src/boot.asm

link-kernel-and-boot:
	cat build/boot.bin build/kernel.bin > build/boot-kernel.bin

build-kernel: build-source build-boot link-kernel-and-boot
	cp build/base.img build/kernel.img
	dd if=build/boot-kernel.bin of=build/kernel.img conv=notrunc

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
