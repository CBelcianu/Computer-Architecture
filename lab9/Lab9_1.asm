bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fread,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
sir resb 1000
nume_fisier db "lab9_input.txt",0 ; fisierul contine textul: abcdfedddbBAT123%
fd dd -1
moda db "r"
lungime dd 0
format db '%d'
    ; ...

; our code starts here
segment code use32 class=code
    start:
    push dword moda
    push dword nume_fisier
    call [fopen] ; deschidem fisierul
    add esp,4*2
    mov [fd],eax
    cmp eax,0 
    je final ; eax==0 => eroare la deschidearea fisierului
    push dword [fd]
    push dword 50
    push dword 1
    push dword sir
    call [fread] ; citim din fisier
    add esp,4*4
    mov [lungime],eax
    mov ebx,0
    mov esi,sir
    mov ecx,[lungime]
    repeta:
        lodsb
        cmp al,'a'
        je vocala
        cmp al,'e'
        je vocala
        cmp al,'i'
        je vocala
        cmp al,'o'
        je vocala
        cmp al,'u'
        je vocala
        cmp al,'A'
        je vocala
        jb vocala
        cmp al,'E'
        je vocala
        cmp al,'I'
        je vocala
        cmp al,'O'
        je vocala
        cmp al,'U'
        je vocala
        cmp al,'z'
        ja vocala
        inc ebx ; byte-ul curent reprezinta o consoana => incrementam contorul
    loop repeta
    jmp afisare
    vocala:
        loop repeta
    jmp afisare
    afisare:
        push ebx
        push dword format
        call [printf]
        add eax,4*2
    final:
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
