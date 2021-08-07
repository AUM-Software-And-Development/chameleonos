[Bits 16]                               ; Set the bit limits to 16, because the computer is still in real mode at this point.
[Org 0]                                 ; Instruct the program counter to place this program into whichever address is first relative to the current program control.
jmp 0x7c0:0x02                          ; Jumps to the address 0x7c0, (which is where all modern computers following standard convention load kernels to) with an offset to the instruction after the jump. That means to jump to the address plus however many bytes to get to the next line.
                                        ; Usually it's referred to as 0x7c00, but the second zero counts as an offset from origin zero, which this assembly is doing manually. Assembly uses segment:offset rules where a jump can allow a source address, and destination address from the source.
                                        ; 0x7c0:0x0 would shift 7c0 16 bits left, and insert the zero as part of the address: 0x7c0_ becomes 0x7c00 as does 0x7c0_ becoming 0x7c0_Boot_

    mov byte [bootDisk], dl             ; Stores the BIOS default drive in memory for later access. The BIOS is expected to load its selected drive number into DL before booting.
    mov ax, cs                          ; The instruction pointer uses segment offsets like the one above, so it needs to have the code segment loaded into a special purpose register
    mov ds, ax                          ; To get the data segment address from. Without it, you can't use the variables that are defined in a file.
    mov si, bootMessageArray
    mov dx, 0x102                       ; 0000001000000001b. Dx order matches number of new lines printed in order of big endian. The function operates in little endian order.
    call display_Padded_ArrayFromSi_
    call drive_AddSectorTwoIntoAddress0x1000_
    jmp 0x0:0x1000

%include "../Bootloader/16BitInstructions/_16Bits_Int0x10_(Display)_.asm"
%include "../Bootloader/16BitInstructions/_16Bits_Int0x13_(Disk)_.asm"

bootMessageArray:
    db '0x7c0 was loaded with instructions to display this.', 0

bootDisk:
    db 0

times 510-($-$$) db 0
db 0x55
db 0xaa