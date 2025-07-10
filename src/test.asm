format binary
org 0x7c00

main:
    mov ah, 0x00
    mov al, 0x13
    int 10h                 ; VGA mode

    push 0xa000             ; VGA 13h frame buffer memory segment
    pop es                  ; set 'es' to video memory segment. We can't mov it directly

game_loop:
    mov al, 0x1
    call paint_background

    mov bx, 50              ; x
    mov dx, 50              ; y
    mov cx, 100             ; width
    mov si, 50              ; height
    call draw_rect

    cli
    hlt

wait_vsync:
    mov dx, 0x3da
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
;   - BX = x position
;   - DX = y position
;   - CX = width
;   - SI = height
;   - AL = color
draw_rect:
    push si
    push cx
    push dx
    push bx

    ; Calculate position in the frame buffer
    pop bx
    pop dx

    mov ax, dx
    mov cx, 320
    mul cx                  ; ax = ax * cx
    add ax, bx

    pop cx
    mov bp, cx
    pop si

    push ax

draw_row_loop:
    pop di
    mov cx, bp
    call draw_row
    add di, 320
    sub di, bp
    push di
    dec si
    test si, si
    jnz draw_row_loop

    ret

draw_row:
    mov al, 0x4
    rep stosb
    ret

; Parameters:
;   AL: color
paint_background:
    mov cx, 320*200
    xor di, di
    rep stosb
    ret

;clear_background:
;    push es
;    push di
;    push ax
;    push cx
;
;    xor di, di
;    xor ax, ax
;    mov cx, 32000           ; 320*200/2 words (64000 bytes / 2)
;    rep stosw               ; Fill video memory with zeros
;
;    pop cx
;    pop ax
;    pop di
;    pop es
;    ret

times 510-($-$$) db 0
dw 0xaa55
