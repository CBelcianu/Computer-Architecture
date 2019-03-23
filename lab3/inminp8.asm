bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 1
    b db 1
    c db 6
    d dw 5
; our code starts here
segment code use32 class=code
    start:
        mov AL, [a] ;AL=a=1 (01(h))
        mov BL, 100 ;BL=100 (64(h))
        mul BL ;AX=AL*BL=100 (64(h))
        mov BX, [d] ;BX=d=5 (05(h))
        add AX, BX ;AX=AX+BX=100+5=105 (69(h))
        add AX, 5 ;AX=AX+5=105+5=110 (6E(h))
        mov BX, AX ;BX=AX=110 (6E(h))
        mov AL, [b] ;AL=b=1 (01(h))
        mov CL, 75 ;CL=75 (4B(h))
        mul CL ;AX=CL*AL=75 (4B(h))
        sub BX, AX ;BX=BX-AX=110-75=35 (23(h)) (100*a+d+5-75*b)
        mov AL , [c] ;AL=c=6 (06(h))
        sub AL, 5 ;AL=AL-5=1 (01(h)) (c-5)
        mov CL, AL ;CL=AL=1 (01(h))
        mov AX, BX ;AX=BX=35 (23(h))
        div CL ;AX=AX/CL=35 (23(h)) (100*a+d+5-75*b)/(c-5)
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
