BITS 16

start:

	;The bootloader has initalized ax to our memory location
    mov ds, ax
    mov es, ax

	add ax, 288
    mov ss, ax
    mov sp, 4096
	
	invoke io_print_string, welcome_string

.cli_loop:

	invoke cli
    jmp .cli_loop

	welcome_string db 'Welcome to ObjectOS 0.0.1!', 13, 10, 0
	prompt db 13, 10, '?', 0    
	input_buffer resb 64
    db 0
    parse_token resb 64
    db 0
	
