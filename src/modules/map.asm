map_array resw 16


get_hashcode:
	call custom_hash
	ret

;Need 32-bits for this
djb2_hash:
	push bp
    mov bp, sp

    ;push ax
	;push si
    ;push bx

    mov si, [bp+4]
    mov cx, 5381 
	xor dx, dx

.loop:
    xor ax, ax
    lodsb
    cmp al, 0
    je .done
	inc dx
	mov bx, cx
	shl cx, 5
	add cx, bx
    add cx, ax
    jmp .loop

.done:
	
    ;pop bx
    ;pop si
    ;pop ax
    pop bp
    ret 2
	
; while (c = *str++) {    
;  hash += c
; }
; return hash + (hash << 1)

custom_hash:
	push bp
	mov bp, sp

	push ax
	push si
	push bx
	
	mov si, [bp+4]
	xor cx, cx
	
.loop:
	xor ax, ax
	lodsb
	cmp al, 0
	je .done
	add cx, ax 
	jmp .loop

.done:
	mov bx, cx
	shl cx, 1 
	add cx, bx 

	pop bx	
	pop si
	pop ax
	pop bp
	ret 2

map_put:
	push bp
	mov bp, sp
	
	push bx
	push dx	
	push cx
	push ax

	mov dx, [bp+6] ;key_object

	push dx
	call get_hashcode

	xor dx, dx
	mov ax, cx
	mov cx, 16
	div cx

	mov bx, dx
	shl bx, 1
	mov dx, [bp+4]
	mov word [map_array+bx], dx 

	pop ax	
	pop cx
	pop dx
	pop bx

	pop bp
	ret 4	


map_get:

	ret

