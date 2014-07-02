get_keystroke:
    mov ah, 00h
    int 16h
    ret

print_char:
    mov ah, 0Eh
    int 10h
    ret

clear_string:
	push bp
	push cx
	push di

	mov bp, sp
	mov cx, [bp+8]
	mov di, [bp+10]

.loop:
	cmp cx, 0
	je .done
	mov al, 0
	stosb
	dec cx
	jmp .loop

.done
	pop di
	pop cx
	pop bp
	ret 4

print_string:
	push bp
	push si
	push ax

	mov bp, sp
	mov si, [bp+8]

	mov ah, 0Eh

.repeat
	lodsb
	cmp al, 0
	je .done
	int 10h
	jmp .repeat

.done
	pop ax
	pop si
	pop bp
	ret 2
