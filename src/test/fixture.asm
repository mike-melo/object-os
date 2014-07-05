BITS 16

jmp start

success_string db 'Success', 0
fail_string db 'Fail', 0

assert:
	push test_name
	call print_string
	je .success
	jmp .fail

.success:
	push success_string
	call print_string
	jmp .done

.fail:
	push fail_string
	call print_string
	jmp .done

.done:
	ret

start:

	;The bootloader has initalized ax to our memory location
        mov ds, ax
        mov es, ax

	add ax, 288             
        mov ss, ax
        mov sp, 4096

