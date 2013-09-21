;The handle for the new object is returned in bx
new_object:
        push si
        push cx
        push dx
        push es

        ;Prepare our next object
        mov bx, [next_object]
        mov cx, [next_object]
        add cx, ax 
        mov [next_object],cx

        ;Make the object out of whatever is in DS:SI and store it in our object heap
        mov dx, 08e1h
        mov es, dx
        mov di, bx

        mov cx, ax 

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
        ret
