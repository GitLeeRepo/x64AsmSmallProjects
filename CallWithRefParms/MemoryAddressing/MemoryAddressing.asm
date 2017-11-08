; MemoryAddress.asm - Pg 42 of Modern X86 Assembly Language Programming, by Daniel Kusswurm
;
; Illutrates different memory addressing techniques relative to the stack base pointer
; all of which are valid and will produce the same result (all the returned values:
; v1, v2, v3, v4 will be the same for a given index, since the effective memory address
; accessed in the FibVals array is the same for each
;
; extern "C" int MemoryAddress(int i, int v1, int v2, int v3, int v4)

.model flat,c

.const

FibVals			dword 0, 1, 1, 2, 3, 5, 8, 13
				dword 21, 34, 55, 89, 144, 233, 377, 610

NumFibVals_		dword  ($ - Fibvals) / sizeof dword
				public NumFibVals_
     
.code

MemoryAddressing_  proc

; Function prolog
        push ebp
        mov ebp,esp
		push ebx
		push esi
		push edi

; Make sure 'i' is valid
		xor eax,eax
		mov ecx,[ebp+8]
		cmp ecx,0
		jl InvalidIndex
		cmp ecx,[NumFibVals_]
		jge InvalidIndex

; Example #1 - base register (ebx)
		mov ebx,offset FibVals                   ; load address of FibVals
		mov esi,[ebp+8]                          ; load 'i' value which is the c++ loop counter parameter
		shl esi,2                                ; multiply by 4 byte offset
		add ebx,esi                              ; ebx has the offset into FibVals array
		mov eax,[ebx]                            ; Get the value at this offset in FibVals array, Ex 1 method
		mov edi,[ebp+12]                         ; Load the address of the v1 parameter
		mov [edi],eax                            ; save the value at to the  v1 address location

		; Example #2 - base register (esi) + displacement 
		mov esi,[ebp+8]                          ; load 'i' value which is the c++ loop counter parameter
		shl esi,2                                ; multiply by 4 byte offset
		mov eax,[esi+FibVals]                    ; Get the value at this offset in FibVals array, Ex 2 method
		mov edi,[ebp+16]                         ; Load the address of the v2 parameter
		mov [edi],eax                            ; save the value at to the v2 address location

		; Example #3 - base register (ebx) + index register (esi)
		mov ebx,offset FibVals                   ; load address of FibVals
		mov esi,[ebp+8]                          ; load 'i' value which is the c++ loop counter parameter
		shl esi,2                                ; multiply by 4 byte offset
		mov eax,[ebx+esi]                        ; Get the value at this offset in FibVals array, Ex 3 method
		mov edi,[ebp+20]                         ; Load the address of the v3 parameter
		mov [edi],eax                            ; save the value at to the v3 address location

		; Example #4 - base register (ebx) + index register (esi) * Scale Factor
		mov ebx,offset FibVals                   ; load address of FibVals
		mov esi,[ebp+8]                          ; load 'i' value which is the c++ loop counter parameter
		mov eax,[ebx+esi*4]                      ; Get the value at this offset in FibVals array, Ex 4 method
		mov edi,[ebp+24]                         ; Load the address of the v1 parameter
		mov [edi],eax                            ; save the value at to the  v1 address location



		; sucessful run
		mov eax,1
		jmp Done

InvalidIndex:
;		mov eax,-1

Done:

; Function epilog
		pop edi
		pop esi
		pop ebx
        mov esp,ebp                         ;deallocate local stack variables
        pop ebp
        ret
MemoryAddressing_  endp
        end