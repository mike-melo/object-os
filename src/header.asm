BITS 16

start:
        mov ax, 07C0h           ; Set up 4K stack space after this bootloader
        add ax, 288             ; (4096 + 512) / 16 bytes per paragraph
        mov ss, ax
        mov sp, 4096

        mov ax, 07C0h           ; Set data segment to where we're loaded
        mov ds, ax
        mov es, ax

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
