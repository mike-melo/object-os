cli:
	push ax
	push dx	
	push di
	
	push input_buffer
	push 16
        call clear_string

        push prompt
        call print_string

        ;Input size starts at 0
	mov dx, 0 
	mov di, input_buffer

.echo_loop:
        call echo
        jmp .echo_loop
        ret

echo:
        call get_keystroke
        cmp al, 13
        je .newline
        stosb
        inc dx

.printchar:
        call print_char
        ret

.newline:
        mov al, 13
        call print_char
        mov al, 10
        call print_char
        mov si, input_buffer
     	sub dx, 2
	
	push input_buffer
	push dx
	call parse
        call cli

	pop ax
	pop dx
	pop di
        ret
