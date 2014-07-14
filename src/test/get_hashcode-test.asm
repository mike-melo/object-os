	invoke custom_hash, input

    cmp cx, 3156
	je success
	jmp fail
	jmp $ 

    input db 'Hello World', 0
	test_name db 'custom_hash-test ==> ', 0
	