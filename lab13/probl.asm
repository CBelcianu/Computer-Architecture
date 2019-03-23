bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    text db "introduceti sir:",0
    format db "%c",0
    sir times 4 dw 0
    a dw 0
    frm db "%d",0
    
; our code starts here
segment code use32 class=code
    start:
        push dword text
        call [printf]
        add esp,4*1
        mov ebx,0
        repeta:
            push dword a
            push dword format
            call [scanf]
            add esp,4*2
            mov ax,[a]
            mov [sir+ebx],ax
            inc ebx
            cmp ebx,4
            je continua
            jne repeta
        continua:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
