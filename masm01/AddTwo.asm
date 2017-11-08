; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

helloWorld db "Hello, World!", 0dh, 0ah, 0dh, 0ah, 0
eaxStr BYTE "Decimal eax value = ", 0
ebxStr BYTE "Decimal ebx value = ", 0
addThis DWORD 6


.code
main proc
    ; Note: WriteString uses the pointer in edx and WriteDec uses the value in eax
    ;       so these registers will be used throughtout for these purposes

    mov edx, OFFSET helloWorld
    call WriteString
    mov edx, OFFSET eaxStr

    mov eax,5    
    call WriteString
    call WriteDec
    call dumpRegs

    add eax,[addThis]    
    call WriteString
    call WriteDec
    call dumpRegs

    mov ebx,10
    xchg eax,ebx              ; exchange so you can display ebx value in WriteDec
    mov edx, OFFSET ebxStr
    call WriteString
    mov edx, OFFSET eaxStr    ; set it back since all the rest are eaxStr
    call WriteDec
    xchg eax,ebx              ; swap them back so eax can continue to be accumulator
    call dumpRegs


    add eax,ebx
    call WriteString
    call WriteDec
    call dumpRegs

    sub eax,11
    call WriteString
    call WriteDec
    call dumpRegs

    invoke ExitProcess,0
main endp
end main