extern malloc
extern asm_normalize
extern asm_cross
extern free

global asm_samplelight

section .data

%define samples [ebp+8]
%define size [ebp+12]
%define light [ebp+16]
;%define lights [ebp+20]
%define u [ebp-16]
%define v [ebp-32]
%define n [ebp-48]

 uno: dd 1.0
 treinta: dd 30.0
 diez: dd 10.0
 dos: dd 2.0
 lights: dd 0

section .text

asm_samplelight:

	enter 48,0
	push ebx
	push esi
	push edi
	
	cmp dword [lights], 0
	je seguir
	push dword [lights]
	call free
	add esp, 4
seguir:
	mov eax, samples
	mov edx, 16
	mul edx
	push eax
	call malloc
	add esp, 4
	mov ebx, eax
	mov [lights], ebx
	;mov [lights], ebx
	mov esi, light
	
	cmp dword samples, 1
	jne masdeuna
	mov edx, [esi+12]
	mov ecx, uno
	mov [esi+12], ecx
	movups xmm1, [esi]
	movups [ebx], xmm1
	mov [esi+12], edx
	mov eax, esi
	jmp fin
	;movups [esi], xmm0
		
masdeuna:
	;mov eax, [treinta]
	movd xmm0, [treinta]
	pslldq xmm0, 4
	;movss xmm0, [diez]
	pslldq xmm0, 4
	movd xmm7, [diez]
	pslldq xmm7, 4
	addps xmm0,xmm7
	movups xmm1, [esi]
	addps xmm0, xmm1
	;push 16
	;call malloc
	;add esp, 4
	lea edi, n
	movups [edi], xmm0
	push edi
	call asm_normalize
	add esp, 4
	movups xmm6, [edi]
	;push 16
	;call malloc
	;add esp, 4
	lea ebx, u
	mov eax, [uno]
	movd xmm0, eax
	pslldq xmm0, 4
	movups [ebx], xmm0
	;push 16
	;call malloc
	;add esp,4
	lea esi, v
	push esi
	push edi
	push ebx
	call asm_cross
	add esp, 12
	
	push esi
	call asm_normalize
	add esp, 4
	
	push ebx
	push esi
	push edi
	call asm_cross
	add esp, 12
	
	push ebx
	call asm_normalize
	add esp, 4
	
	;mov 
	movd xmm7, [dos]
	pshufd xmm7, xmm7, 00000000
	cvtsi2ss xmm6, size
	pshufd xmm6, xmm6, 00000000
	divps xmm6, xmm7
	movups xmm0, [esi]
	mulps xmm0, xmm6
	movups [esi],xmm0
	movups xmm0, [ebx] 
	mulps xmm0, xmm6
	movups [ebx], xmm0
	;movd xmm0, samples
	cvtsi2ss xmm0, samples
	sqrtps xmm0, xmm0
	cvttss2si eax, xmm0
	movd xmm1, [dos]
	divps xmm1, xmm0
	movups xmm4,xmm1
	movd xmm0, [uno]
	subps xmm1, xmm0
	pshufd xmm1, xmm1, 00000000
	xor ecx, ecx
	movups xmm2, xmm1
	movups xmm7, [ebx] ;u
	movups xmm6, [esi];v
	mov edi, eax
	mov esi, [lights]
	mov ebx, light
	movups xmm5, [ebx]
	movups xmm0, xmm4


ciclo1:
	movups xmm3, xmm1
	xor edx, edx

ciclo2: 
	mov eax, ecx
	push edx
	mul edi
	pop edx
	add eax, edx
	shl eax, 4
	
	;push edx
	;mov edx, 16
	;mul edx
	;pop edx
	;movups xmm0, [ebx+eax]
	;movups xmm4, xmm5
	movups xmm5, xmm6
	mulps xmm5, xmm3
	movups xmm4, xmm7
	mulps xmm4, xmm2
	addps xmm5, xmm4
	movups xmm4, [ebx]
	addps xmm5, xmm4
	movups [esi+eax], xmm5
	movss xmm5, [uno]
	movss [esi+eax+12], xmm5
	addps xmm3, xmm0
	inc edx
	cmp edx, edi
	jne ciclo2
	
	addps xmm2, xmm0
	inc ecx
	cmp ecx, edi
	jne ciclo1
	
	;mov eax, [lights]
	
	
fin:
	;lea esi, n
	;push esi
	;call free
	;add esp,4
	;lea edi, 
	;push edi
	;call free
	;add esp,4
	
	mov eax, [lights]
	
	pop edi
	pop esi
	pop ebx
	leave
ret
