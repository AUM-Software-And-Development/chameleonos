                                        ;;;;;;;;;;

display_Array_:
    pusha
    mov ah, 0x0e
.scanArrayLoop:
    mov al, [si]
    cmp al, 0
    je .exit
    int 0x10
    inc si
    jmp .scanArrayLoop
.exit:
    popa
    ret

                                        ;;;;;;;;;;

display_Padded_ArrayFromSi_:
    pusha
    xor cx, cx
loop1:
    cmp ch, dh
    je exitloop1
    call display_NewLine_
    inc ch
    jmp loop1
exitloop1:
    call display_Array_
loop2:
    cmp cl, dl
    je exitloop2
    call display_NewLine_
    inc cl
    jmp loop2
exitloop2:
    popa
    ret

                                        ;;;;;;;;;;

display_NewLine_:
    pusha
    mov ax, 0x0e0a
    int 0x10
    mov al, 0dh
    int 0x10
    popa
    ret

                                        ;;;;;;;;;;