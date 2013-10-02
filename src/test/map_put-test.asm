	push test_string 
	push 3Fh 
	call map_put 
       	
	push test_string 
	push 3Fh 
	call map_put 
	
	push test_string 
	push 3Fh 
	call map_put 

	push test_string2
	push 3dh
	call map_put
	
	jmp $

        test_string db 'abc', 0
        test_string2 db 'def', 0
