bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit
extern printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll
    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
d dd 12345678h,1256ABCDh,12AB4344h
longafisare equ $-d
l equ 3
format db '%x ',0
aux dw 0
aux2 dw 0
    ; ...

; our code starts here
segment code use32 class=code
    start:
    mov ebx,l
    repeta2:
        cmp ebx,0
        je afisare
        mov esi,d
        mov ecx,l
        dec ecx
        mov edi,d
        add edi,4
        cld
        repeta:
            cmpsw
            jg maimare
            loop repeta
        dec ebx
        jmp repeta2
    maimare:
        ;sub edi,2
        ;sub esi,2
        movsw
        add edi,4
        add esi,4
        loop repeta
        jmp repeta2
    afisare:
        mov esi,0
        afisare2:
        cmp esi,longafisare
        je final
        pushad
        mov eax,[d+esi]
        push eax
        push dword format
        call [printf]
        add esp,4*2
        popad
        add esi,4
        jmp afisare2
    final:
    
        
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
