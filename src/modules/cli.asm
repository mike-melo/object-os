cli:
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
    jmp .echo

.echo:
    call get_keystroke
    cmp al, 13
    je .newline
    stosb
    inc dx
    call print_char
    jmp .echo_loop

.newline:
    mov al, 13
    call print_char
    mov al, 10
    call print_char
    sub dx, 2

    push input_buffer
	push dx
	call parse
    jmp .done

.done:
    pop di
	pop dx

    ret
	