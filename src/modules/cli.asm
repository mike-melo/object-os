cli:
        mov cx, 16            ; Our input buffer limit
        mov di, input_buffer
        call clear_string

        mov di, input_buffer
        mov si, prompt
        call print_string

        ;Get our input buffer max setup
        mov cx, 16

.echo_loop:
        call echo
        jmp .echo_loop
        ret

echo:
        call get_keystroke
        cmp al, 13
        je .newline
        ;If we have got to 0, that means don't store anymore
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
        call parse
        call cli
        ret
