bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a1 db 1
    a2 db 3
    a3 db a1-a2
    format dd '%d',0

; our code starts here
segment code use32 class=code
    start:
        mov eax,0ffh
        mov ebx,100h
        sub eax,ebx
        ;mov ebx,2
        ;sub eax,ebx
        push eax
        push dword format
        call [printf]
        add esp,4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
