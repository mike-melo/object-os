BITS 16

start:

.reset:

	;Reset the floppy disk controller
	mov ah, 0
	mov dl, 0
	int 13h
	jc .reset
	
.read:

	mov ah, 2
	mov al, 1 
	mov ch, 0 
	mov cl, 2 
	mov dh, 0
	mov dl, 0
	mov bx, 050h  
        mov es, bx     
        xor bx, bx 

	int 13h
	jc .read	

        mov ax, 050h         

	jmp 0x0050:0x0000

	times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
	dw 0xAA55               ; The standard PC boot signature
