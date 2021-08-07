[Bits 16]
[Org 0x1000]
jmp 0x1200                              
times 512-($-$$) db 0                   ; Null data section.

    mov ax, cs
    mov ds, ax
    mov es, ax
    mov si, kernelLocatedArray
    mov dx, 0x202
    call display_Padded_ArrayFromSi_
_EnableA20_:                            ; Fast enable, built into modern computer archecture.
    in al, 92h
    or al, 2
    out 92h, al
_EnableAndDefineGolbalDescriptorTableRouting_:
    cli
    lgdt[_GlobalDescriptorTable_]
    mov eax, cr0                        ; Get the register value of cr0 which is used to switch this ability on or off.
    or eax, 1h                          ; Or the least significant bit value with 1, which is by default 0 in cr0, thus setting the least significant bit to 1.
    mov cr0, eax                        ; Move the new value into cr0 so that the hardware can complete its functions using the designated routes.
    jmp _CodeSegment_:_32BitProtectedMode_

[Bits 32]
_32BitProtectedMode_:
    mov ax, _DataSegment_
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x90000                    ; Place ebp for the most stack space.
    mov esp, ebp
Kernel:
    mov byte [0x000b8000], 'K'
    mov byte [0x000b8002], 'e'
    mov byte [0x000b8004], 'r'
    mov byte [0x000b8006], 'n'
    mov byte [0x000b8008], 'e'
    mov byte [0x000b800a], 'l'
    jmp $

kernelLocatedArray:
    db 'The kernel was found at relative address 0x100:0x200.', 0

[Bits 16]
%include "../Bootloader/16BitInstructions/_16Bits_Int0x10_(Display)_.asm"
%include "../Kernel/16BitSwitchRouting/_16Bits_GlobalDescriptorTable_(EnterProtectedMode)_.asm"

times 1024-($-$$) db 0