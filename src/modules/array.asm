;returns ptr to new array at bx
array_new:
	push bp
	mov bp, sp
	
	invoke mem_alloc, word [bp+4]
	
	pop bp
	ret 2
	
;arg1 [bp+8] -> array index
;arg2 [bp+6] -> ptr to array
;arg4 [bp+4] -> size of read
;return address of read bytes into bx
array_read:
	push bp
	mov bp, sp
	
	push dx
	push ds
	
	mov dx, [bp+6]
	add dx, [bp+8]

	invoke mem_alloc, word [bp+4]
	
	;The assumption is that the source data is in the heap (7e0h)

	push dx
	mov dx, 7e0h
	mov ds, dx
	pop dx
	
	invoke mem_write, dx, bx, word [bp+4]
	
	pop ds
	pop dx
	pop bp
	ret 6

;arg2 [bp+10] -> array index
;arg3 [bp+8] -> ptr to array
;arg4 [bp+6] -> ptr to bytes to write
;arg5 [bp+4] -> size of write
array_write:
	push bp
	mov bp, sp
	
	push bx
	
	mov bx, [bp+8]
	add bx, [bp+10]
	
	invoke mem_write, word [bp+6], bx, word [bp+4]
	
	pop bx
	pop bp
	ret 8
	