;returns ptr to new array at bx
array_new:
	push bp
	mov bp, sp
	
	push word [bp+4] 
	call mem_alloc
	
	pop bp
	ret 2

;arg1 [bp+10] -> array index
;arg2 [bp+8] -> ptr to array
;arg3 [bp+6] -> ptr to bytes to write
;arg4 [bp+4] -> size of write
array_write:
	push bp
	mov bp, sp
	
	push bx
	
	mov bx, [bp+8]
	add bx, [bp+10]
	
	push word [bp+6] 		
	push bx
	push word [bp+4]
	call mem_write
	
	pop bx
	pop bp
	ret 8
	