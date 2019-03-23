bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir db 2,5,2,4,2,2,4,4
    len equ $-sir
    rez times 3 dw 0
    format db "%d",0
    aparitii db 0,0,0,0,0,0,0,0,0
    c db 0

; our code starts here
segment code use32 class=code
    start:
        mov edi,sir
        std
        mov eax,0
        mov ebx,0
        mov ecx,0
        mov dl,0
        repeta:
            mov al,[sir+ebx]
            scasb
            je gasit
            ok:
            inc ebx
            cmp ebx,len
            jne repeta
        mov ebx,0
        mov ecx,0
        jmp cont
        gasit:
            inc edi
            mov dl, 1
            add [aparitii+eax],dl
            jmp ok
        cont:
            mov al,[aparitii+ebx]
            jz ok2
            mov ah,bl
            mov [rez+ecx],ax
            inc ecx
            inc ebx
            jne cont
        mov esi,0
        jmp afisare
        ok2:
            inc ebx
            cmp ebx,len
            jne cont
        mov esi,0
        jmp afisare
        afisare:
            cmp esi,3
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
