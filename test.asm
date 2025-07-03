; https://en.wikipedia.org/wiki/INT_10H

org 0x7c00
bits 16

main:
    mov ah, 00h
    mov al, 13h
    int 10h

draw_loop:
    mov ah, 0ch
    mov al, dl
    and al, 4
    mov bh, 1
    int 10h

    inc cx
    cmp cx, 319
    jne draw_loop

    mov cx, 0
    inc dx
    cmp dx, 200
    jne draw_loop

    hlt
halt:
    jmp halt

times 510-($-$$) db 0
dw 0xaa55
