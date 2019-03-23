bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit ,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir db 2,5,2,4,2,2,4,4
    len equ $-sir
    rez dw 0,0,0
    format db "%d",0

; our code starts here
segment code use32 class=code
    start:
        std
        mov ebx,0
        mov ecx,0
        mov al,[sir+ebx]
        cbw
        mov [rez+ecx],ax
        inc ecx
        inc ebx
        mov edi,rez
        repeta:
            mov al,[sir+ebx]
            cbw
            stosw
            jne adauga
            continua:
            inc ebx
            cmp ebx,len
            jne repeta
        mov esi,0
        jmp afisare
        adauga:
            inc edi
            mov[rez+ebx],ax
            inc ecx
            mov edi,rez
            jmp continua
        mov esi,0
        jmp afisare
        afisare:
            cmp esi,ecx
            je final
            pushad
            mov ax,[rez+esi]
            cwde
            push dword eax
            push dword format
            call [printf]
            add esp,4*2
            popad
            inc esi ;incrementam esi
            jmp afisare ;sarim la eticheta efisare
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
