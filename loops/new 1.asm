bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit ,fopen, fprintf, fclose,scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
    ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura numere si sa se scrie valorile citite in fisier pana cand se citeste de la tastatura valoarea 0.
segment data use32 class=data
    nume_fisier dd "work2.txt", 0  ; numele fisierului care va fi creat
    mod_acces dd "w", 0          ; modul de deschidere a fisierului - 
                                 ; w - pentru scriere. daca fiserul nu exista, se va crea      
    numar dd 0                   ; numarul care va fi introdus in fisier
    format dd "%d",0             ; formatul numarului citit
    format2 dd "%d ",0           ; formatul numarului afisat
    format3 dd "%x ",0
    descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    ; ...

; our code starts here
segment code use32 class=code
    start:
        ; apelam fopen pentru a crea fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je final
        
        bucla:
        ;citim numarul de la tastatura
        push numar
        push dword format
        call [scanf]
        add esp, 4*2
        
        ;comparam valoarea cu 0
        mov ebx, dword [numar]
        cmp ebx, 0
        JE closefile
        
        ; scriem textul in fisierul deschis folosind functia fprintf
        ; fprintf(descriptor_fis, numar)
        pushad
        push ebx
        push dword format2
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*3
        popad
        
        pushad
        push ebx
        push dword format3
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*3
        popad
        
        mov edx,0
        
        interiorbucla:
        mov eax, 1
        mov ecx, ebx
        and ecx, eax
        cmp ecx, 1
        jne nem
        inc edx
        nem:
        shr ebx,1
        cmp ebx, 0
        jE afarabucla
        jmp interiorbucla
        
        afarabucla:
        
        pushad
        push edx
        push dword format2
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*3
        popad
        
        jmp bucla
        
        closefile:
        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
        final:
        ; ...
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program