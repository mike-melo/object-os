;Initialize bx to something so we can make sure array_new sets it	
	mov bx, 99
	invoke array_new, 10

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
	