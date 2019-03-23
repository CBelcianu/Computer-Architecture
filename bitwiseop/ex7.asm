bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0101000011110110b
    b dw 0101001001011101b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        mov AX,0000000000011111b ;AX=000000011111b (1Fh)
        or [c],AX  ;c=00000000000000000000000000011111b (1Fh)
        mov AX,[a] ;AX=0101000011110110b (50F6h)
        mov DX,0 ;DX=0
        push DX
        push AX
        pop EAX ;EAX=00000000000000000101000011110110b (50F6h)
        shl EAX,5 ;EAX=00000000000010100001111011000000b 
        and EAX,00000000000000000000111111100000b ; EAX=00000000000000000000111011000000b (EC0Dh)
        or [c],EAX ;c=000000000000000000000111011011111b 
        mov AX,[b] ;AX=0101001001011101b
        mov DX,0 ;DX=0
        push DX
        push AX
        pop EAX ;EAX=00000000000000000101001001011101b (525Dh)
        shl EAX,4 ;EAX=00000000000001010010010111010000b
        and EAX,00000000000000001111000000000000b ; EAX=00000000000000000010000000000000b (2000h)
        or [c],EAX ;c=00000000000000000010111011011111b
        mov AX,0 ;AX=0
        mov DX,0000000001100101b ;DX=0000000001100101b
        push DX
        push AX
        pop EAX ;EAX=00000000011001010000000000000000b (650000h)
        or [c],EAX ;c=00000000011001010010111011011111b (652EDF)
        mov EAX,[c]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
