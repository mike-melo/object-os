BITS 16

jmp start

success_string db 'Success', 0
fail_string db 'Fail', 0

success:
	push test_name
	call io_print_string
	push success_string
	call io_print_string
	jmp $
	
fail:
	push test_name
	call io_print_string
	push fail_string
	call io_print_string
	jmp $
	
start:

	;The bootloader has initalized ax to our memory location
        mov ds, ax
        mov es, ax

	add ax, 288             
        mov ss, ax
        mov sp, 4096

