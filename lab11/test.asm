bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

extern oct
; our data is declared here (the variables needed by our program)
segment data use32 public data
    frm db "%o ",0
    frm2 db "%c ",0

; our code starts here
segment code use32 public code
    start:
        mov eax,32
        repeta:
            ;pushad
            ;push dword eax
            ;push dword frm
            ;call [printf]
            ;add esp,4*2
            ;popad
            ;pushad
            ;push dword eax
            ;push dword frm2
            ;call [printf]
            ;add esp,4*2
            ;popad
            call oct
            add eax,1
            cmp eax,126
            jg final
            jle repeta
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
