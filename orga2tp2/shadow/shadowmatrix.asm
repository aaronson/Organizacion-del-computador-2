section .data

global asm_shadowmatrix

%define matrix [ebp+8]
%define plane [ebp+12]
%define lightpos [ebp+16]

section .text

;flo: dw 0

asm_shadowmatrix:
	
	enter 0,0
	push esi
	push edi
	push ebx
	
	mov ebx, matrix
	mov edi, plane
	mov esi, lightpos
	
	movups xmm0, [edi]
	movups xmm1, [esi]
	mulps xmm0, xmm1
	haddps xmm0, xmm0
	haddps xmm0, xmm0
	;movd xmm3, [flo]
	;pshufd xmm3, xmm3, 00000000
	movd eax, xmm0
	movd xmm3, eax
	movd xmm2, [edi]
	shufps xmm2, xmm2, 00000000
	mulps xmm2, xmm1
	movups xmm4, xmm3
	subps xmm4, xmm2
	movups [ebx], xmm4
	add ebx, 16
	movd xmm2, [edi+4]
	shufps xmm2, xmm2, 00000000
	mulps xmm2, xmm1
	pslldq xmm3, 4
	;movd xmm3, eax
	movups xmm4, xmm3
	subps xmm4, xmm2
	movups [ebx], xmm4
	add ebx, 16
	movd xmm2, [edi+8]
	shufps xmm2, xmm2, 00000000
	mulps xmm2, xmm1
	pslldq xmm3, 4
	;movd xmm3, eax
	movups xmm4, xmm3
	subps xmm4, xmm2
	movups [ebx], xmm4
	add ebx, 16
	movd xmm2, [edi+12]
	shufps xmm2, xmm2, 00000000
	mulps xmm2, xmm1
	pslldq xmm3, 4
	;movd xmm3, eax
	movups xmm4, xmm3
	subps xmm4, xmm2
	movups [ebx], xmm4
	
	
	pop ebx
	pop edi
	pop esi
	leave
ret
