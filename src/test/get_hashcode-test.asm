	push input
	call custom_hash
    cmp cx, 31567
	je success
	jmp fail
	jmp $ 

    input db 'Hello World', 0
	test_name db 'custom_hash-test ==> ', 0
	