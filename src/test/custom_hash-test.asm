	push input
	call custom_hash
    cmp cx, 3156
	call assert
	jmp $ 

    input db 'Hello World', 0
	test_name db 'custom_hash-test ==> '
	