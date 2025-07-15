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

    mov bx, 30              ; x
    mov dx, 30              ; y
    mov cx, 50              ; base width
    mov si, 50              ; height
    mov al, 0x4
    call draw_triangle

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
;   - CX = base width
;   - SI = height
;   - AL = color
draw_triangle:
    push ax
    push si
    push cx
    push dx
    push bx

    ; Calculate starting position: y * 320 + x
    mov ax, dx          ; y position
    mov cx, 320
    mul cx              ; ax = y * 320
    add ax, bx          ; ax = y * 320 + x
    mov di, ax

    pop bx
    pop dx
    pop cx
    pop si

    mov ax, cx          ; ax = width
    div si              ; base / height
    mov bp, ax

    pop ax

    mov cx, 1

draw_row:
    push cx             ; save current width
    push di             ; save row start position
    rep stosb           ; draw the row

    pop cx              ; restore width
    inc cx
    pop di              ; restore row start position
    add di, 320         ; move to next row

    dec si
    jnz draw_row
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
