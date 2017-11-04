; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

.386
.model flat,c
.stack 4096


.code

CalcSum_ proc

   ; Initialize a stack frame pointer

    push ebp
    mov ebp, esp

	; Load the arguement values
    mov eax,[ebp+8]                      ; eax=a
    mov ecx,[ebp+12]                     ; eax=b
    mov edx,[ebp+16]                     ; edx=c

	; Calculate the sum
	add eax,ecx
    add eax,edx

   ; Restore the caller's stack frame pointer
	pop ebp
	ret
CalcSum_ endp
end

