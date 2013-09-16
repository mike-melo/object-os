get_keystroke:
        mov ah, 00h
        int 16h
        ret

print_char:
        mov ah, 0Eh
        int 10h
        ret

clear_string:
        cmp cx, 0
        je .done
        mov al, 0
        stosb
        dec cx
        jmp clear_string
.done:
        ret

print_string:                   ; Routine: output string in SI to screen
        mov ah, 0Eh             ; int 10h 'print char' function

.repeat:
        lodsb                   ; Get character from string
        cmp al, 0
        je .done                ; If char is zero, end of string
        int 10h                 ; Otherwise, print it
        jmp .repeat

.done:
        ret

