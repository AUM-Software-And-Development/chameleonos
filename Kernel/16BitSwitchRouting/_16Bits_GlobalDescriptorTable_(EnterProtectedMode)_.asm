_GDTBegin_:
_nullDescriptor_:
    dd 0x0                              ; Define double word (4 bytes) 
    dd 0x0
_codeSegment_:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0
_dataSegment_:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
_GDTEnd_:

_GlobalDescriptorTable_:
    dw _GDTEnd_ - _GDTBegin_ - 1        ; The size "always" equates to 65536 bytes or 8192 entries, but the max bit limitation is 65535.
    dd _GDTBegin_
                                        
_CodeSegment_: equ _codeSegment_ - _GDTBegin_
_DataSegment_: equ _dataSegment_ - _GDTBegin_