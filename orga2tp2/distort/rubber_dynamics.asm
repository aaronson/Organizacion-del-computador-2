extern asm_updateStates
extern updateStates

global asm_rubber_dynamics

section .data

%define mass_size 44
%define spring_size 12

SPRING_KS: dd 0.3


section .text

asm_rubber_dynamics:

	enter 0,0
	push esi
	push edi
	push ebx
	
; 	mov eax, [ebp+16]
; 	mov ecx, spring_size
; 	mul ecx
; 	mov ecx, eax
	xor ecx, ecx
	mov ebx, [ebp+20]
	mov esi, [ebp+24]
	mov edi, [esi]
	
	
ciclo1:
	mov eax, mass_size
	mul edi
	movups xmm0, [ebx+eax]
	add eax, mass_size
	movups xmm1, [ebx+eax]
	subps xmm0, xmm1
	movups xmm1, xmm0
	mulps xmm0, xmm0
	pslldq xmm0, 4
	haddps xmm0, xmm0
	haddps xmm0, xmm0
	sqrtps xmm0, xmm0
	cvtss2si eax, xmm0
	cmp eax, 0
	je seguirciclo1
	;pshufd xmm0, xmm0, 00000000
	divps xmm1, xmm0
	mov eax, [esi+8]
	;mov edx, SPRING_KS
	;mul eax
	movd xmm2, eax
	pshufd xmm2, xmm2, 00000000
	subps xmm0, xmm2
	mov eax, [SPRING_KS]
	movd xmm2, eax
	pshufd xmm2, xmm2, 00000000
	mulps xmm0, xmm2
	mulps xmm1, xmm0
	mov eax, mass_size
	mul edi
	movups xmm0, [ebx+eax+16]
	subps xmm0, xmm1
	movups [ebx+eax+16], xmm0
	add eax, mass_size
	movups xmm0, [ebx+eax+16]
	addps xmm0, xmm1
	movups [ebx+eax+16], xmm0
	

seguirciclo1:
	add esi, spring_size
	inc edi
	inc ecx
	cmp ecx, 210
	je prepararciclo2
	jmp ciclo1
	
prepararciclo2:
	mov esi, [ebp+24]
	mov eax, spring_size
 	mul ecx
 	add esi, eax
 	mov eax, mass_size
 	mul dword [esi]
 	movups xmm0, [ebx+eax]
 	mov eax, mass_size
 	mul dword [esi+4]
 	movups xmm1, [ebx+eax]
 	subps xmm0, xmm1
 	movups xmm1, xmm0
 	mulps xmm0, xmm0
 	pslldq xmm0, 4
	haddps xmm0, xmm0
 	haddps xmm0, xmm0
 	sqrtps xmm0, xmm0
 	cvtss2si eax, xmm0
 	cmp eax, 0
 	je seguirciclo2
	;pshufd xmm0, xmm0, 00000000
 	divps xmm1, xmm0
	mov eax, [esi+8]
	;mov edx, SPRING_KS
 	;mul eax
 	movd xmm2, eax
 	pshufd xmm2, xmm2, 00000000
	subps xmm0, xmm2
 	mov eax, [SPRING_KS]
 	movd xmm2, eax
 	pshufd xmm2, xmm2, 00000000
 	mulps xmm0, xmm2
 	mulps xmm1, xmm0
	mov eax, mass_size
 	mul dword [esi]
 	movups xmm0, [ebx+eax+16]
 	subps xmm0, xmm1
 	movups [ebx+eax+16], xmm0
 	mov eax, mass_size
 	mul dword [esi+4]
 	movups xmm0, [ebx+eax+16]
 	addps xmm0, xmm1
 	movups [ebx+eax+16], xmm0
 	
 	seguirciclo2:
 	inc ecx
 	cmp ecx, [ebp+16]
 	je fin
 	jmp prepararciclo2 
		

fin:
	;mov eax,[ebp+28]
	push dword [ebp+20]
	push dword [ebp+28]
	push dword [ebp+12]
	push dword [ebp+8]
	call asm_updateStates
	;call updateStates
	add esp, 16
	pop ebx
	pop edi
	pop esi
	leave
ret
