	push 10
	call array_new

	;push ds
	push 0
	push bx
	push input
	push 4	
	call array_write	

	;arg1 [bp+8] -> array index
	;arg2 [bp+6] -> ptr to array
	;arg4 [bp+4] -> size of read
	push 0
	push bx
	push 3
	call array_read
	
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
	cmp byte [es:bx], 0
	jne fail
	
	je success
	jmp fail
	jmp $
	
    input db 'abcd1234', 0
	test_name db 'array_write-test ==> ', 0
	