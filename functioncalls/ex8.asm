bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 10
    b dw 0
    c dd 0
    d dd 0
    v dd 0
    format db "%d", 0
    text db "%d + %d\%d = %d rest %d",0
    textb db "Introduceti b=",0

; our code starts here
segment code use32 class=code
    start:
        push dword textb
        call [printf]
        add esp, 4*1 ;afisam textul: "Introduceti b="
        push dword b
        push dword format
        call [scanf] ;citim variabila b de la tastatura
        add esp, 4*2
        mov eax,[a] ;EAX=a=10
        mov bx,[b] ;BX=b
        idiv bx ;AX=a/b DX=a%b
        mov ebx,0 ;EBX=0
        mov ecx,0 ;EBX=0
        mov bx,ax ;BX=AX=a/b
        mov cx,dx ;CX=DX=a%b
        mov [c],ebx ;c=EBX=a/b
        mov [d],ecx ;d=ECX=a%b
        mov eax,[a] ;EAX=a=10
        add [c],eax ;c=c+EAX=a/b+a
        mov ax,[b] ;AX=b
        cwde ;EAX=b
        mov [v],eax ;v=EAX=b
        push dword [d]
        push dword [c]
        push dword [v]
        push dword [a]
        push dword [a]
        push dword text
        call [printf] ;afisam rezultatul
        add esp, 4*6
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
