bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fread,fprintf,fclose    ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll   ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fread msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    fisier_initial db "p9input.txt",0
    fisier_pare db "pare.txt",0
    fisier_impare db "impare.txt",0
    sir resb 1000
    descf db -1
    descp db -1
    desci db -1
    mod_initial db "r"
    mod_pi db "a"
    lungime db 0
; our code starts here
segment code use32 class=code
    start:
        push dword mod_initial
        push dword fisier_initial
        call [fopen]
        add esp, 4*2
        
        mov [descf],eax
        cmp eax,0
        je final
        
        push dword [descf]
        push dword 50
        push dword 1
        push dword sir
        call [fread]
        add esp,4*4
        
        mov [lungime],eax
        mov ebx,0
        mov esi,sir
        mov ecx,[lungime]
        mov dl,2
        repeta:
            lodsb
            cbw
            div dl 
            cmp ah,0
            je par
            jne impar
            inc ebx
            loop repeta
        jmp final
        par:
            pushad
            push dword mod_pi
            push dword fisier_pare
            call [fopen]
            add esp,4*2
            mov [descp],eax
        
            push dword [sir+ebx]
            push dword [descp]
            call [fprintf]
            add esp, 4*2
            
            push dword [descp]
            call [fclose]
            add esp,4*1
            popad
            dec ecx
            jmp repeta
        jmp final
        impar:
            pushad
            push dword mod_pi
            push dword fisier_impare
            call [fopen]
            add esp,4*2
            mov [desci],eax
            
            push dword [sir+ebx]
            push dword [desci]
            call [fprintf]
            add esp, 4*2
            
            push dword [desci]
            call [fclose]
            add esp,4*1
            popad
            dec ecx
            jmp repeta
        
        
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
