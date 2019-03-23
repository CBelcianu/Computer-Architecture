bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,fopen,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                       ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;import fprint msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir resb 1000
    var db 0
    fdesc dd -1
    maccess db "w"
    fis db "intrare.txt",0
    format db "%d",0
    format2 db "%x ",0
    format3 db "%d ",0

; our code starts here
segment code use32 class=code
    start:
        mov ebx,0
        repeta:
            push dword var
            push dword format
            call [scanf]
            add esp,4*2
            mov al,[var]
            mov [sir+ebx],al
            inc ebx
            cmp al,0
            je continua
            jne repeta
        continua:
        mov ecx,0
        fa:
            mov al,[sir+ecx]
            cbw
            cwd
            cwde
            pushad
            push dword eax
            push dword format3
            call [printf]
            add esp,4*2
            popad
            pushad
            push dword eax
            push dword format2
            call [printf]
            add esp,4*2
            popad
            inc ecx
            cmp ecx,ebx
            je gata
            jne fa
        gata:
            
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
