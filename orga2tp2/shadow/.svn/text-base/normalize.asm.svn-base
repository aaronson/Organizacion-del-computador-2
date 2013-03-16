global asm_normalize

section .text

asm_normalize:

	enter 0,0
	push edi
	push esi
	push ebx
	
	;requiere que la cuarta pos este en 0
	mov ebx, [ebp+8]
	mov edx, [ebx+12]
	mov dword[ebx+12],0
	movups xmm0, [ebx]
	movups xmm1, xmm0
	mulps xmm1, xmm1
	haddps xmm1, xmm1
	haddps xmm1, xmm1
	sqrtps xmm1, xmm1
	divps xmm0, xmm1
	movups [ebx], xmm0
	mov [ebx+12], edx
		
	pop ebx
	pop esi
	pop edi
	leave
ret
