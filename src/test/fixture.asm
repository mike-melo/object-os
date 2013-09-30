BITS 16

start:

	;The bootloader has initalized ax to our memory location
        mov ds, ax
        mov es, ax

	add ax, 288             
        mov ss, ax
        mov sp, 4096
