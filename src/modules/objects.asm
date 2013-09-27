;The handle for the new object is returned in bx
new_object:
	push bp
        push si
        push cx
        push dx
        push es

    	mov bp, sp
	mov si, [bp+14]

        ;Prepare our next object
        mov bx, [next_object]
        mov cx, [next_object]
        add cx, [bp+12] 
        mov [next_object], cx

        ;Make the object out of whatever is in DS:SI and store it in our object heap
        mov dx, 7e0h
        mov es, dx
        mov di, bx

        mov cx, [bp+12] 

.copy:
        cmp cx, 0
        je .done
        mov al,[si]
        inc si
        stosb
        dec cx
        jmp .copy

.done:
        pop es
        pop dx
        pop cx
        pop si
	pop bp
        ret 4 
