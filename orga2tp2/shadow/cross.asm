section .data

%define u [ebp+8]
%define v [ebp+12]
%define n [ebp+16]

global asm_cross
section .text

asm_cross: 
	enter 0,0
	push edi
	push esi
	push ebx
	
	mov esi, u
	mov edi, v
	mov ebx, n
	
	movups xmm0, [esi]
	movups xmm1, [edi]
	movups xmm2, xmm0
	movups xmm3, xmm1
	psrldq xmm2, 4
	psrldq xmm3, 4
	movlhps xmm2, xmm0
	movlhps xmm3, xmm1
	pslldq xmm0, 4
	pslldq xmm1, 4
	
	movss xmm6, [esi+8]
	movss xmm7, [edi+8]
	addps xmm0,xmm6
	addps xmm1,xmm7
	mulps xmm2, xmm1
	mulps xmm0, xmm3
	subps xmm2, xmm0
	movups [ebx],xmm2
	
	pop ebx
	pop esi
	pop edi
	leave
ret
