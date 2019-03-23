bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0110110010100100b
    b dw 0011001011010100b
    c db 0
    d dd 0
; our code starts here
segment code use32 class=code
    start:
        mov AX,[a] ;AX=0110110010100100b (6CA4)
        shr AX,5 ;AX=0000001101100101b (365h)
        and AX,0000000000111111b ;AX=0000000000100101b (25h)
        or [c],AX ; bits 0-5 of c should be bits 5-10 of a c=00100101
        mov AX,[b] ;AX=1011001011010100b (B2D4h)
        shl AX,4 ;AX=0010110101000000b (2D40h)
        and AX,0000000011000000b ; AX=0000000001000000b (40h)
        or [c],AX  ;bits 6-7 of c should be bits 1-2 of b c=01100101b (65h)
        mov AX,[c] ;AX=01100101b
        mov DX,0
        push DX
        push AX
        pop EAX;AX=00000000001100101b (65h)
        shl EAX,8
        and EAX,00000000000000000111111100000000b ;EAX=00000000000000000110010100000000b (6500h)
        or [d],EAX ;bits 8-15 of d should be the bits of c d=00000000000000000110010100000000b
        mov AX,[b]
        mov DX,0
        push DX
        push AX
        pop EAX
        shr EAX,8 ;EAX=00000000000000000000000000110010b (32h)
        or [d],EAX ;d=00000000000000000110010110110010b
        mov AX,[a]
        and AX,00000000011111111b; AX=0000000010100100b (A4h)
        mov DX,0
        push DX
        push AX
        pop EAX
        shl EAX,24 ;EAX=00000000011011000000000000000000b (6C0000h)
        or [d],EAX ;d=10100100000000000110010110110010b
        mov AX,[a]
        mov DX,0
        push DX
        push AX
        pop EAX
        shl EAX,8 ;EAX=0000000001101100101001000b (D948h)
        and EAX,00000000111111110000000000000000b ; EAX=00000000011011000000000000000000b (6C0000h)
        or [d],EAX ; d=10100100011011000110010100110010b (A46C6532h)
        mov EAX,[d] ;EAX=A46C6532h
        mov BL,[c] ;BX=65h
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
