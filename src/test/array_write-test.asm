	push 10
	call array_new
	push bx
	
	push 0
	push bx
	push input
	push 4	
	call array_write	

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
	