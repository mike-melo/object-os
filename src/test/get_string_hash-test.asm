	push test_string 
	call get_string_hash 
       	jmp $ 

        test_string db 'Hello World', 0
