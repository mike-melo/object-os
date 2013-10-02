	push test_string 
	call get_hashcode 
       	jmp $ 

        test_string db 'Hello World', 0
