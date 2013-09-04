BITS 16

start:
	mov ax, 07C0h		; Set up 4K stack space after this bootloader
	add ax, 288		; (4096 + 512) / 16 bytes per paragraph
	mov ss, ax
	mov sp, 4096

	mov ax, 07C0h		; Set data segment to where we're loaded
	mov ds, ax

	mov si, welcome_string	; Put string position into SI
	call print_string	; Call our string-printing routine
	
	call cli
	jmp $
	
	welcome_string db 'Welcome to ObjectOS 0.0.1!', 13, 10, 0

cli:

	call show_prompt

.echo_loop:
	call echo
	jmp .echo_loop
	ret

show_prompt:
	mov ah, 0EH
	mov al, '?'
	int 10h
	ret

echo:
	call get_keystroke
	cmp al,13
	je .newline
	call print_char
	ret
.newline
	mov al,13
	call print_char
	mov al,10
	call print_char
	call show_prompt	
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
