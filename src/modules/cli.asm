cli:
        mov cx, 16            ; Our input buffer limit
        mov di, input_buffer
        call clear_string

        mov di, input_buffer
        mov si, prompt
        call print_string

        ;Input size starts at 0
	mov dx, 0 

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
     	sub dx,2
	call parse
        call cli
        ret
