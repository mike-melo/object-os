BITS 16

start:

.reset:

	;Reset the floppy disk controller
	mov ah, 0
	mov dl, 0
	int 0x13
	jc .reset
	
.read:

	mov ah, 2
	mov al, 1 
	mov ch, 0 
	mov cl, 2 
	mov dh, 0
	mov dl, 0
	mov bx, 0x2000  
        mov es, bx     
        xor bx, bx 

	int 0x13
	jc .read	

        mov ax, 0x2000          

	jmp 0x2000:0x0000

	times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
	dw 0xAA55               ; The standard PC boot signature
