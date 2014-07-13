BITS 16

jmp start

success_string db 'Success', 0
fail_string db 'Fail', 0

success:
	invoke io_print_string, test_name
	invoke io_print_string, success_string
	jmp $
	
fail:
	invoke io_print_string, test_name
	invoke io_print_string, fail_string
	jmp $
	
start:

	;The bootloader has initalized ax to our memory location
    mov ds, ax
    mov es, ax

	add ax, 288             
    mov ss, ax
    mov sp, 4096

