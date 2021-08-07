; AH = 02
; AL = Number of sectors to read (1-128 decimal)
; CH = Track/cylinder number (0-1023 decimal, see below)
; CL = Sector number (0-17 decimal)
; DH = Head number (0-15 decimal)
; DL = Drive number (0=A:, 1=2nd floppy, 80h=drive 0, 81h=drive 1)

; On return:
; AH = Status
; AL = Number of sectors that were read
; CF = 0 (if success)
; CF = 1 (if error)

; The documentation recommends attempting a disk read at least 3 times if it fails.

drive_AddSectorTwoIntoAddress0x1000_:
    mov si, attemptingReadArray
    call display_Array_

    xor ax, ax
    mov es, ax
    mov ah, 0x02
    mov al, 2
    mov bx, 0x1000
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0
    int 0x13
    ret

        ; This needs an error mechanism!

attemptingReadArray:
    db 'Attempting to read the disk number your computer BIOS loaded into dl....', 0