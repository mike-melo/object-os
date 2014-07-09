cli:
    push dx
    push di

	push input_buffer
	push 16
    call io_clear_string

    push prompt
    call io_print_string

    ;Input size starts at 0
	mov dx, 0
	mov di, input_buffer

.echo_loop:
    jmp .echo

.echo:
    call io_get_keystroke
    cmp al, 13
    je .newline
    stosb
    inc dx
    call io_print_char
    jmp .echo_loop

.newline:
    mov al, 13
    call io_print_char
    mov al, 10
    call io_print_char
    sub dx, 2

    push input_buffer
	push dx
	call parse
    jmp .done

.done:
    pop di
	pop dx

    ret
	