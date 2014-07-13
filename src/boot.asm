BITS 16

start:

	push 050h
	push 2
	call read_sectors
   
	mov ax, 050h         

	jmp 0x0050:0x0000

;This won't read anything past sectors 18; need a special algorithm for that

read_sectors:
	push bp
	push cx
	
	mov bp, sp
	mov bx, [bp+8]

.reset:
	;Reset the floppy disk controller
	mov ah, 0
	mov dl, 0
	int 13h
	jc .reset
	
.read:
	mov ah, 2 
	mov al, BYTE [bp+6]
	mov ch, 0 
	mov cl, 2 
	mov dh, 0
	mov dl, 0
	mov es, bx

	xor bx, bx		
	
	int 13h
	jc .read
	
.done:	
	pop cx
	pop bp
	ret 4

	times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
	dw 0xAA55               ; The standard PC boot signature