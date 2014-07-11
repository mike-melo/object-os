;Initialize bx to something so we can make sure array_new sets it	
	mov bx, 99
	push 10
	call array_new
	
;Assert that the return value in bx is pointing to the array
	cmp bx, 0
	jne fail
	mov bx, [mem_next_alloc]
	cmp bx, 10
	je success
	jmp fail
	jmp $  

    input db 'abcd1234', 0
	test_name db 'array_write-test ==> ', 0
	