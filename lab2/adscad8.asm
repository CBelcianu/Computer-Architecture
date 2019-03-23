bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10
    b db 5
    d db 4

; our code starts here
segment code use32 class=code
    start:
    mov AL, [a] ; AL = a = 10 (0A(h))
    mov AH, [b] ; AH = b = 5 (05(h))
    add AL, AH ; AL = AL + AH = 10 + 5 = 15 (0F(h)) (a+b)
    mov AH, [d] ; AH = d = 4 (04(h))
    sub AL, AH ; AL = AL - AH = 15 - 4 = 11 (0B(h)) (a+b-d)
    mov BL, [a] ; BL = a = 10 (0A(h))
    mov BH, [b] ; BH = b = 5 (05(h))
    sub BL, BH ; BL = BL - BH = 10 - 5 = 5 (05(h)) (a-b)
    mov BH, [d] ; BH = d = 4 (04(h))
    sub BL, BH ; BL = BL - BH = 5 - 4 =1 (01(h)) (a-b-d)
    add AL, BL ; AL = AL + BL = 11 + 1 = 12 (0C(h)) (a+b-d)+(a-b-d)
    
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
