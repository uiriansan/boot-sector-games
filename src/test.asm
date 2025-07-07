format binary
org 0x7c00

main:
    mov ah, 00h
    mov al, 13h
    int 10h         ; VGA mode

    hlt
    jmp $

times 510-($-$$) db 0
dw 0xaa55
