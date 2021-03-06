mem_next_alloc dw 0

;The memory ptr is returned in bx
mem_alloc:
	push bp
	mov bp, sp
	
	push cx
	
	mov bx, [mem_next_alloc]
    mov cx, [mem_next_alloc]
    add cx, [bp+4]
    mov [mem_next_alloc], cx
	
	pop cx
	pop bp
	ret 2

;Make sure you do this before the call so you get the right ds:
;   push dx
;	mov dx, 7e0h
;	mov ds, dx
;	pop dx

;arg2 [bp+8] -> ptr to source data
;arg3 [bp+6] -> ptr to dest data
;arg4 [bp+4] -> number of bytes to write
@proc mem_write:
	@paramword size
	@paramword dest
	@paramword source
	
	push bp
	mov bp, sp
	
	push si
	push cx
	push dx
	push es
		
	mov cx, size
	mov bx, dest
	mov si, source
	
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
@endproc

;arg1 [bp+6] -> source
;arg2 [bp+4] -> number of bytes to write
mem_copy:
	push bp
	mov bp, sp

	push bx

	invoke mem_alloc, word [bp+4]

	;bx returned from mem_alloc is the destination
	invoke mem_write, word [bp+6], bx, word [bp+4]
	
	pop bx
	pop bp
	ret 4

deprecated_mem_copy:
	push bp
    push si
    push cx
    push dx
    push es

    mov bp, sp
	mov si, [bp+14]

    ;Prepare our next object
    mov bx, [mem_next_alloc]
    mov cx, [mem_next_alloc]
    add cx, [bp+12]
    mov [mem_next_alloc], cx

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
