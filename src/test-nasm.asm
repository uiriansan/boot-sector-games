bits 16
org 0x7c00

main:
    mov ah, 0x00
    mov al, 0x13
    int 10h         ; VGA mode

game_loop:
    call clear_background

    call draw_rect

    call wait_vsync

    hlt
    jmp halt

wait_vsync:
    mov dx, 0x03da
wait_vsync_end:
    in al, dx
    test al, 8
    jnz wait_vsync_end
wait_vsync_start:
    in al, dx
    test al, 8
    jz wait_vsync_start
    ret

; Function to draw a filled rectangle
; Parameters:
;   - CX = x position
;   - DX = y position
;   - BX = width
;   - SI = height
;   - AL = color
draw_rect:
    mov di, 0x0a000          ; video memory segment
    mov es, di              ; set 'es' to video memory

draw_pixel:
    mov ah, 0x0c
    mov al, 4
    mov bh, 0
    mov cx, di
    add cx, rect_w         ; di + width
    mov dx, si
    add dx, rect_h         ; di + height
    int 10h                ; write pixel

    ret

clear_background:
    push es
    push di
    push ax
    push cx

    mov ax, 0x0a000          ; VGA video memory segment
    mov es, ax              ; Set ES to video memory
    xor di, di              ; Start at beginning of video memory
    xor ax, ax              ; Fill with color 0 (black)
    mov cx, 32000           ; 320*200/2 words (64000 bytes / 2)
    rep stosw               ; Fill video memory with zeros

    pop cx
    pop ax
    pop di
    pop es

halt:
    jmp halt

rect_w: db 100 ; 100x35 rect
rect_h: db 35

times 510-($-$$) db 0
dw 0xaa55
