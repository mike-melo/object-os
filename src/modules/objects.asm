;The handle for the new object is returned in bx
alloc_object:
	push bp
	mov bp, sp
	
	push cx
	
	mov bx, [next_object]
    mov cx, [next_object]
    add cx, [bp+4]
    mov [next_object], cx
	
	pop cx
	pop bp
	ret 2
	
;arg1 [bp+8] -> ptr to source data
;arg2 [bp+6] -> ptr to dest data
;arg3 [bp+4] -> number of bytes to write
write_object:
	push bp
	mov bp, sp
	
	push si
	push cx
	push dx
	push es
	
	mov cx, [bp+4]
	mov bx, [bp+6]
	mov si, [bp+8]

	;Make the object out of whatever is in DS:SI and store it in our object heap
    mov dx, 7e0h
    mov es, dx
    mov di, bx

.copy:
    cmp cx, 0
    je .done
    mov al,[si]
    inc si
    stosb
    dec cx
    jmp .copy

.done:	
	pop es
	pop dx
	pop cx
	pop si
	pop bp
	ret 6

;arg1 [bp+6] -> source
;arg2 [bp+4] -> number of bytes to write
new_object:
	push bp
	mov bp, sp

	push bx

	push word [bp+4]
	call alloc_object
	
	push word [bp+6] 		
	push bx					;bx returned from alloc_object is the destination
	push word [bp+4]
	call write_object
	
	pop bx
	pop bp
	ret 4

deprecated_new_object:
	push bp
    push si
    push cx
    push dx
    push es

    mov bp, sp
	mov si, [bp+14]

    ;Prepare our next object
    mov bx, [next_object]
    mov cx, [next_object]
    add cx, [bp+12]
    mov [next_object], cx

    ;Make the object out of whatever is in DS:SI and store it in our object heap
    mov dx, 7e0h
    mov es, dx
    mov di, bx

    mov cx, [bp+12]

.copy:
    cmp cx, 0
    je .done
    mov al,[si]
    inc si
    stosb
    dec cx
    jmp .copy

.done:
    pop es
    pop dx
    pop cx
    pop si
    pop bp
    ret 4
