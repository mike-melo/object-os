cli:
    push dx
    push di

	invoke io_clear_string, input_buffer, 16
    invoke io_print_string, prompt

    ;Input size starts at 0
	mov dx, 0
	mov di, input_buffer

.echo_loop:
    jmp .echo

.echo:
	
    invoke io_get_keystroke
	
	cmp al, 13
    je .newline
    stosb
    inc dx
    
	invoke io_print_char
	jmp .echo_loop

.newline:
    mov al, 13
    invoke io_print_char
	mov al, 10
	invoke io_print_char
    sub dx, 2

    invoke parse, input_buffer, dx
	jmp .done

.done:
    pop di
	pop dx

    ret
	