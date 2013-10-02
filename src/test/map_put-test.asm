	push test_string 
	push 11h 
	call map_put 
       	jmp $ 

        test_string db 'abc', 0
