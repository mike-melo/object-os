parse_string:
        push di
        push bx
        mov di, parse_token
.loop:
        lodsb
        cmp al, '"'
        je .done
        stosb
        jmp .loop
.done:
        mov bx, si
        mov si, parse_token
        call new_object
        mov si, bx
        pop bx
        pop di
        ret

parse:
        push si
.loop:
        lodsb
        cmp al, 0 
        je .done
        ;This check is to make sure we don't exceed of buffer limit
        cmp cx, 0
        je .done
        dec cx
        cmp al,'"'
        jne .loop

        call parse_string
        jmp .loop
.done:
        pop si
        ret
