bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10
    b dw 5
    d dq 4
    aux dd 0

; our code starts here
segment code use32 class=code
    start:
        mov AL,[a] ;AL=a=10 
        mov AH,0 ;AH=0
        mov DX,0 ;DX=0
        div word [b] ;AX=DX:AX/b=10/5=2
        mul word [b] ;AX=AX*b=2*5=10=a (0A(16))
        mov BX,[b] ;BX=b=5 (05(16))
        add AX,BX ;AX=AX+BX=15 (0F(16))
        mov DX,BX ;DX=BX=5
        mov EBX,[d] 
        mov ECX,[d+4] ;ECX:EBX=d=4 (04(16))
        mov DX,0
        push DX
        push AX
        pop EAX ; EAX=a+b=15 (0F(16))
        mov EDX,0
        sub EDX,ECX
        sbb EAX,EBX ; EDX:EAX=a+b-d=15-6=11 (0B(16) (a+b-d)
        push EDX
        push EAX
        pop dword [aux]
        mov AL,[a] ;AL=a=10
        mov AH,0 ;AH=0
        mov DX,0 ;DX=0
        div word [b] ;AX=DX:AX/b=10/5=2
        mul word [b] ;AX=AX*b=2*5=10=a (0A(16))
        mov BX,[b] ;BX=b=5 (05(16))
        sub AX,BX ;AX=AX-BX=5 (05(16))
        mov DX,BX ;DX=BX=5
        mov EBX,[d] 
        mov ECX,[d+4] ;ECX:EBX=d=6 (04(16))
        mov DX,0
        push DX
        push AX
        pop EAX ; EAX=a-b=5 (05(16))
        mov EDX,0
        sub EDX,ECX
        sbb EAX,EBX ; EDX:EAX=a-b-d=5-4=1 (01(16)) (a-b-d)
        mov EBX,[aux]
        add EAX,EBX ; EAX=EAX+EBX=(a+b-d)+(a-b-d)=11+1=12 (0C(16))
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
