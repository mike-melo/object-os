
module_name db 'mdl_map', 0

value_object dw 20 
 
;push module_name 
;push value_object 
;call map_put

get_string_hash:
	push bp
	mov bp, sp

	push ax
	push si
	
	mov si, [bp+4]
	xor cx, cx
	
.loop:
	xor ax, ax
	lodsb
	cmp al, 0
	je .done
	add cx,ax
	jmp .loop

.done:
	mov ax, 31
	mul cx
	pop si
	pop ax
	pop bp
	ret 2

map_put:
	push bp
	mov bp, sp
	
	push bx
	push dx	

	mov bx, [bp+4] ;value_object
	mov dx, [bp+6] ;key_object

	pop dx
	pop bx

	pop bp
	ret 4	


map_get:

	ret

