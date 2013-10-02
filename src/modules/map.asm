
module_name db 'mdl_map', 0

value_object dw 20 

map_array resw 16
 
get_hashcode:
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
	mov di, map_array

	pop ax	
	pop cx
	pop dx
	pop bx

	pop bp
	ret 4	


map_get:

	ret

