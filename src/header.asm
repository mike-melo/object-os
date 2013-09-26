BITS 16

start:

	;The bootloader has initalized ax to our memory location
        mov ds, ax
        mov es, ax

	add ax, 288             
        mov ss, ax
        mov sp, 4096

	push welcome_string
	call print_string
        call cli
        hlt

        welcome_string db 'Welcome to ObjectOS 0.0.1!', 13, 10, 0
        prompt db 13, 10, '?', 0
        input_buffer resb 64 
        db 0
        parse_token resb 64
        db 0
        next_object dw 0
