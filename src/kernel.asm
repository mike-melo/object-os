BITS 16

start:
	mov ax, 07C0h		; Set up 4K stack space after this bootloader
	add ax, 288		; (4096 + 512) / 16 bytes per paragraph
	mov ss, ax
	mov sp, 4096

	mov ax, 07C0h		; Set data segment to where we're loaded
	mov ds, ax
	mov es, ax

	mov si, welcome_string	; Put string position into SI
	call print_string	; Call our string-printing routine
	
	call cli
	call print_string
	hlt
	
	welcome_string db 'Welcome to ObjectOS 0.0.1!', 13, 10, 0
	prompt db 13, 10, '?', 0
	input_buffer resb 16
	db 0

cli:
	mov cx, 16	      ; Our input buffer limit
	mov di, input_buffer
	call clear_string

	mov cx, 16
	mov di, input_buffer
	mov si, prompt
	call print_string

.echo_loop:
	call echo
	jmp .echo_loop
	ret

echo:
	call get_keystroke
	cmp al, 13
	je .newline
	cmp cx, 0
	je .printchar
	stosb
	dec cx

.printchar:
	call print_char
	ret

.newline:
	mov al, 13
	call print_char
	mov al, 10
	call print_char
	mov si, input_buffer
	call print_string
	call cli	
	ret

clear_string:
	cmp cx, 0
	je .done
	mov al, 0
	stosb
	dec cx
	jmp clear_string
.done:
	ret	
get_keystroke:
	mov ah, 00h
	int 16h
	ret

print_char:
	mov ah, 0Eh
	int 10h
	ret

print_string:			; Routine: output string in SI to screen
	mov ah, 0Eh		; int 10h 'print char' function

.repeat:
	lodsb			; Get character from string
	cmp al, 0
	je .done		; If char is zero, end of string
	int 10h			; Otherwise, print it
	jmp .repeat

.done:
	ret

	times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
	dw 0xAA55		; The standard PC boot signature
