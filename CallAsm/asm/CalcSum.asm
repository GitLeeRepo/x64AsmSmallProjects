; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

.386
.model flat,c
.stack 4096


.code

CalcSum_ proc

   ; Initialize a stack frame pointer

    push ebp                             ; save the caller's base (stack frame) pointer
    mov ebp, esp                         ; set the new base for this proc to the current top of the stack

    ; Load the parameter values
    mov eax,[ebp+8]                      ; eax=a (4-byte int)
    mov ecx,[ebp+12]                     ; eax=b (4-byte int)
    mov edx,[ebp+16]                     ; edx=c (4-byte int)

    ; Calculate the sum
    add eax,ecx
    add eax,edx

   ; Restore the caller's stack frame pointer
    pop ebp
    ret
CalcSum_ endp
end

