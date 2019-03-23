bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit
extern printf
extern scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll 
import scanf msvcrt.dll        ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0
    b dw 0
    c dd 0
    d dd 0
    rezultat dd 0
    format db "%d",0
    text db "%d * %d = %d",0
    texta db "Introduceti a=",0
    textb db "Introduceti b=",0
    ; ...

; our code starts here
segment code use32 class=code
    start:
        push dword texta
        call [printf] ;afisam textul:"Introduceti a="
        add esp, 4*1
        push dword a
        push dword format
        call [scanf] ;citim de la tastatura variabila a"
        add esp, 4*2
        MOV AX,[a] ;AX=a
        MOV BX,AX ;BX=AX=a
        push dword textb
        call [printf] ;afisam textul:"Introduceti b="
        add esp, 4*1
        push dword b
        push dword format
        call [scanf] ;citim variabila b de la tastatura
        add esp, 4*2
        MOV AX,[b] ;AX=b
        iMUL BX ;DX:AX=AX*BX=a*b
        MOV [rezultat],AX
        MOV [rezultat+2],DX ;rezultat=a*b
        ;MOV EAX,[rezultat]
        MOV AX,[b]
        cwde
        MOV [d],eax
        MOV AX, [a]
        cwde
        mov [c],eax
        push dword [rezultat]
        push dword [d]
        push dword [c]
        push dword text
        call [printf] ;afisam rezultatul
        add esp, 4*4
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
