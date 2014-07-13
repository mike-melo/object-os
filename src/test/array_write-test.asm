	invoke array_new, 10
	
	push bx
	
	invoke array_write, 0, bx, input, 4
	
	;Pop the original address of the array
	pop bx
	
	;Heap starts at 7e0h 
	mov dx, 7e0h
	mov es, dx
	
	;Assert
    cmp byte [es:bx], 'a'
	jne fail
	inc bx
	cmp byte [es:bx], 'b'
	jne fail
	inc bx
	cmp byte [es:bx], 'c'
	jne fail
	inc bx
	cmp byte [es:bx], 'd'
	jne fail
	
	je success
	jmp fail
	jmp $
	
    input db 'abcd1234', 0
	test_name db 'array_write-test ==> ', 0
	