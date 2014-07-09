parse_string:
    push di
	push ax

    mov di, parse_token
.loop:
    lodsb
    cmp al, '"'
    je .done
    stosb
    jmp .loop

.done:
	push parse_token
	push dx
	call mem_copy

	pop ax
    pop di
    ret

parse:
	push bp
	push si
	push dx

	mov bp, sp

	mov dx, [bp+8]
	mov si, [bp+10]

.loop:
	lodsb
	cmp al, 0
	je .done
	cmp al,'"'
	jne .loop

	call parse_string
	jmp .loop
	
.done:
	pop dx
	pop si
	pop bp
	ret 4
	