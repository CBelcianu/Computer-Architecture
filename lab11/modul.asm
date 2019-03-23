bits 32
segment data use32 public data
    frm db "%o ",0
    frm2 db "%c ",0


segment code use32 public code
global oct

    start:
        oct:
            pushad
            push dword eax
            push dword frm
            call [printf]
            add esp,4*2
            popad
            pushad
            push dword eax
            push dword frm2
            call [printf]
            add esp,4*2
            popad
        ret
