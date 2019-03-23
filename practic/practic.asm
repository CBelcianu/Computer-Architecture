bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,fopen,fprintf,fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                         ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fis dd 0
    descriptor_fis dd -1
    mod_acc dd "w",0
    format dd "%s",0
    format2 dd "%c",0
    maj resd 20
    min resd 20
    lmaj dd 0
    lmin dd 0

; our code starts here
segment code use32 class=code
    start:
        push dword nume_fis
        push dword format
        call [scanf]
        add esp,4*2
        
        push dword mod_acc
        push dword nume_fis
        call [fopen]
        add esp,4*2
        
        mov [descriptor_fis],eax
        
        cmp eax,0
        je final
        mov ebx,0
        mov edx,0
        mov ecx,0
        repeta:
            mov al,[nume_fis+ebx]
            cmp al,byte 'a'
            jb majuscula
            cbw
            cwd
            cwde
            mov [min+edx],eax
            inc edx
            inc ebx
            cmp ebx,6
            jne repeta
            je continua
        jmp continua    
        majuscula:
            ;mov al,[nume_fis+ebx]
            cbw
            cwd
            cwde
            mov [maj+ecx],eax
            inc ecx
            inc ebx
            cmp ebx,6
            jne repeta
            je continua
        jmp continua
        continua:
        mov [lmaj],ecx
        mov [lmin],edx
        mov ebx,0
        buclamaj:
            pushad
            push dword [maj+ebx]
            push dword format2
            push dword [descriptor_fis]
            call [fprintf]
            add esp,4*2
            popad
            inc ebx
            cmp ebx,[lmaj]
            jb buclamaj
        mov ebx,0
        buclamin:
            pushad
            push dword [min+ebx]
            push dword format2
            push dword [descriptor_fis]
            call [fprintf]
            add esp,4*2
            popad
            inc ebx
            cmp ebx,[lmin]
            jb buclamin
        
        final:
        
        push dword [descriptor_fis]
        call [fclose]
        add esp,4
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
