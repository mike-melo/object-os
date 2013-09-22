parse_string:
        push di
        push bx
	push ax
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
	
	mov ax, dx
	call new_object
        
	mov si, bx
       
	pop ax
	pop bx
        pop di
        ret

parse:
	push bp
	push si
	
	mov bp, sp
	mov dx, [bp+6]
	mov si, [bp+8]

.loop:
	lodsb
	cmp al, 0
	je .done
	cmp al,'"'
	jne .loop
	
	call parse_string
	jmp .loop

.done:
	pop si
	pop bp
	ret
