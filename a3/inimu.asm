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
    c db 4
    d db 1
    x dq 2
    e dd 10

; our code starts here
segment code use32 class=code
    start:
        mov AX, 1 ;AX=1 (01(16)
        mov DX, 0 ;DX=0
        div word [a] ;AX=AX/a=1 (01(16) (1/a)
        mov BX,AX ;BX=1/a=1
        mov AX, 200 ;AX=200 (C8(16))
        mul word [b] ;AX=AX*d=200*1=200 (C8(16)) (200*d)
        add AX,BX ;AX=AX+BX=201 (C9) (1/a+200*d)
        mov CX,AX ;CX=AX=201
        mov AL,[d]
        inc AL ;AL=(d+1)=2 (02(16))
        mov DL,AL ;DL=2
        mov AL,[c] ;AL=c=4 (04(16))
        div DL ;AX=2 (02(16)) (c/(d+1))
        sub CX,AX ;CX=CX+AX=201-2=199 (C7(16) (1/a+200*d-c(d+1)
        mov EAX,[x]
        mov EDX,[x+4] ;EDX:EAX=x=2 (02(16))
        mov EBX, 0
        mov BX, [a]
        div EBX ;AX=x/a=2 (02(16)) (x/a)
        add CX,AX ;CX=1/a+200*-c/(d+1)+x/a=201 (C9(16)) (1/a+200*d-c/(d+1)+x/a)
        mov AX,[e]
        sub CX,AX ;CX=1/a+200*-c/(d+1)+x/a-e=201-10=191 (BF(16)) (1/a+200*d-c/(d+1)+x/a-e)
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
