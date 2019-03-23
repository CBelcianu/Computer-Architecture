bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db 1,3,6,2,3,7
    lens equ $-s1
    s2 db 6,3,8,1,2,5
    d times lens db 0
    format db "%d ",0
; our code starts here
segment code use32 class=code
    start:
        mov ecx,lens ;ecx = lungimea sirului
        mov ebx,0 ;ebx = 0 (contror)
        
        repeat:
            mov al,[s1+ebx] ;al = byte-ul curent din s1
            mov dl,[s2+ebx] ;dl = byte-ul curent din s2
            cmp al,dl
            jg op1 ;daca al>dl sare la eticheta "op1" / daca al<dl continua
            mov [d+ebx],dl ;in byte-ul curent din d stocam valoarea din dl
            inc ebx ;incrementam ebx
            loop repeat ;sarim la eticheta repeat si decrementam ecx
        mov esi,0
        jmp afisare
        op1:
            mov [d+ebx],al ;in byte-ul curent din d stocam valoarea din al
            inc ebx ;incrementam ebx
            loop repeat ;sarim la eticheta repeat si decrementam ecx
        mov esi,0 ;esi=0
        afisare:
            cmp esi,lens
            je final ;daca esi==lens sarim la eticheta final, daca nu, continuam
            pushad
            mov al,[d+esi] ;al = byte-ul curent din d
            cbw
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
