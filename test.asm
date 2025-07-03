org 0x7c00
bits 16

main:
    mov ah, 00h
    mov al, 13h
    int 10h

    push 0
    push 0

draw_pixel_loop:
    mov ah, 0ch
    mov al, 4
    mov bh, 1
    pop cx
    inc cx
    cmp cx, 319
    je increment_row

    pop dx
    int 10h

    push dx
    push cx
    jmp draw_pixel_loop

    hlt
halt:
    jmp halt

increment_row:
    pop dx
    inc dx
    push dx
    push 0
    jmp draw_pixel_loop


times 510-($-$$) db 0
dw 0xaa55
