bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1
    b dw 1
    c db 14
    d db 1
    x dq 2
    e dd 200
    aux dw 0
; our code starts here
segment code use32 class=code
    start:
        mov AX, 1 ;AX=1
        mov DX, 0 ;DX=0
        idiv word [a] ;AX=AX/a=1
        mov BX,AX ;BX=1/a=1 (01(16)) (1/a)
        mov AX, 200 ;AX=200
        imul word [b] ;AX=AX*d=200*1=200 (C8(16)) (200*d)
        add AX,BX ;AX=AX+BX=201 (C9(16)) (1/a+200*d)
        mov CX,AX ;CX=AX=201
        mov AL,[d]
        inc AL ;AL=(d+1)
        mov DL,AL ;DL=2
        mov AL,[c] ;AL=c=14 (0E(16))
        idiv DL ;AX=7 (07(16)) (c/(d+1))
        sub CX,AX ;CX=CX-AX=194 (C2(16)) (1/a+200*d-c/(d+1))
        mov word [aux],CX
        mov AX,[a]
        cwde
        mov EBX,EAX
        mov EAX,[x]
        mov EDX,[x+4] ;EDX:EAX=x=2 (02(16))
        idiv EBX ;EAX=x/a=2 (02(16)) (x/a)
        mov CX,word [aux]
        add CX,AX ;CX=CX+AX=194+2=196 (C4(16)) (1/a+200*b-c/(d+1)+x/a)
        mov AX,[e]
        mov DX,[e+2]
        push DX
        push AX
        pop EAX ;EAX=400 (190(16))
        mov BX, 0
        push BX
        push CX
        pop ECX ;ECX=196
        sub ECX,EAX ;ECX=ECX-EAX=196-400=-4 (FC(16)) (1/a+200*b-c/(d+1)+x/a-e)
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
