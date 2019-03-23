bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 2
    b dw 4
    c dw 3
    d dw 3

; our code starts here
segment code use32 class=code
    start:
        mov AX,[b] ; AX=b=4
        mov BX,[c] ; BX=c=3
        add AX,BX ; AX=AX+BX=4+3=7
        mov BX,AX ; BX=AX=7
        mov AX,[d] ; AX=d=3
        add AX,BX ; AX=AX+BX=3+7=10
        mov BX,AX ; BX=AX=10
        mov AX,[a] ; AX=a=2
        add AX,AX ; AX=AX+AX=2+2=4
        sub BX,AX ; BX=BX-AX=10-4=6
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
