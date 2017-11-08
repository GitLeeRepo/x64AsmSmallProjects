; CalcArraySquares.asm
; Modified version of: Prog on Pg 59 of Modern X86 Assembly Language Programming, by Daniel Kusswurm
;                      Added srcMultFactor parameter.  Also changed parameter order from the book
;
; Demonostrates traversing a source array of integers (dword), multiplying each element by the srcMultFactor
; parameter, and then squaring it by multiplying it with itself, placing the result in the destination array.
;
; extern "C" int CalcArraySquares_(int* destArray, const int* srcArray, int numElements, int srcMultFactor);


.model flat,c
     
.code

CalcArraySquares_  proc

        ; Function prolog
        push ebp
        mov ebp,esp
        push ebx
        push esi
        push edi

        ; Load Arguments
        mov esi,[ebp+8]                         ; srcArray
        mov edi,[ebp+12]                        ; destArray
        mov ecx,[ebp+16]                        ; numElements
                                                ; srcMultFactor [ebp+20] used below

        ; Initialization
        xor eax,eax                             ; zero to track running sum
        cmp ecx,0                               ; make sure NumElements != 0
        jle EmptyArray
        shl ecx,2                               ; size of array (numElements * dword size)
        xor ebx,ebx                             ; zero to index first element

        ; Repeat until finished
@@:     mov edx,[esi+ebx]                       ; get srcArray element value
        imul edx,[ebp+20]                       ; srcMultFactor
        imul edx,edx                            ; square the srcArray element
        mov [edi+ebx],edx                       ; save result to destArray[esi+ebx]
        add eax,edx                             ; running sum
        add ebx,4                               ; increment array element offset
        cmp ebx,ecx
        jl @B                                   ; repeat until end of array reached

EmptyArray:
        ; Function epilog
        pop edi
        pop esi
        pop ebx
        pop ebp
        ret	                                    ; eax = sum
CalcArraySquares_  endp
        end