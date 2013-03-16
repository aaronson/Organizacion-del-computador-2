;extern mass
;extern grab
;extern SPRING

global asm_updateStates

;section .float 0.5

section .data

%define GRID_SIZE_X 16
%define GRID_SIZE_Y 16

%define grab [ebp+16]
%define mass [ebp+20]

%define mass_size 44
;%define coord 0
%define velocidad 16

DRAG: dd 0.5
CLIP_NEAR: dd -0.11
CLIP_FAR: dd -999.99
CLIP_NF: dd -249.975

section .text

asm_updateStates:
	
	enter 0,0
	push esi
	push edi
	push ebx
	
	mov esi, [ebp+8]
 	mov edi, [ebp+12]
	
	
	xor eax, eax
	mov eax, GRID_SIZE_X
	mov ecx, GRID_SIZE_Y
	mul ecx
	mov ecx, eax; Calculo el loop y lo dejo en ecx
	
	
	
	mov eax, [DRAG]; en eax pongo 0.5
	movd xmm2, eax
	pshufd xmm2, xmm2, 00000000; xmm2= [0.5 0.5 0.5 0.5]
	mov eax, [CLIP_NEAR]
	movd xmm6, eax; 
	mov eax, [CLIP_FAR]
	movd xmm7, eax

ciclo: 
	mov eax, [ebx+40]; eax tiene el mass.grab
	cmp eax,0
	jne seguirciclo; sigue en linea 60 if mass[k].nail = 0 

	movups xmm0, [ebx]; xmmo= posicion actual del mass 
	movups xmm1, [ebx+velocidad]
	addps xmm0, xmm1
	movups [ebx], xmm0
	mulps xmm1, xmm2
	movups [ebx+velocidad], xmm1

	mov eax, [ebx+8]
	;cmp eax, [CLIP_NEAR]
	movd xmm0, eax
	movups xmm1, xmm0
	movups xmm3, xmm0
	cmpss xmm0, xmm6, 6
	andps xmm0, xmm6
	cmpss xmm1, xmm6, 2
	andps xmm1, xmm3
	addss xmm0, xmm1
	movd [ebx+8], xmm0
	;~ cmpps xmm0, xmm6, 2
	;~ movd edx, xmm0
	;~ cmp edx, 0
	;~ je camb_clipnear
	;jg camb_clipnear
	movd xmm0, eax
	movups xmm1, xmm0
	movups xmm3, xmm0
	cmpss xmm0, xmm7, 1
	andps xmm0, xmm7
	cmpss xmm1, xmm7, 5
	andps xmm1, xmm3
	addss xmm0, xmm1
	movd [ebx+8], xmm0

	;~ cmpps xmm0, xmm7, 1
	;~ movd edx, xmm0
	;~ cmp edx, 0
	;~ jne camb_clipfar
	;~ ;cmp eax, [CLIP_FAR]
	;~ ;jl camb_clipfar
	;~ jmp seguirciclo
;~ 
;~ 
;~ 
;~ camb_clipnear:
	;~ ;mov eax, [CLIP_NEAR]
	;~ movd [ebx+8], xmm6
	;~ jmp seguirciclo
;~ 
;~ camb_clipfar:
	;~ ;mov eax, [CLIP_FAR]
	;~ movd [ebx+8], xmm7
	;~ jmp seguirciclo
;~ 
seguirciclo:
	add ebx, mass_size
	loop ciclo
	
	mov eax, grab
	cmp eax, -1
	je fin
	
	

	
	mov edx, mass_size
	mul edx
	mov ebx, mass
	movups xmm0, [ebx]
	add ebx, eax
	movups xmm1, [ebx]
	mov eax, [ebx+40]
	cmp eax, 0
	jne fin
	
	xorps xmm5,xmm5
	xorps xmm6,xmm6
	cvtsi2ss xmm5,[ebp+8]
	;mov edi, [ebp+8]
	movss [ebx], xmm5
	cvtsi2ss xmm6,[ebp+12]
	;mov edi, [ebp+12]
	movss [ebx+4], xmm6
	mov edi, [CLIP_NF]
	mov [ebx+8], edi
	
	

fin:
	pop ebx
	pop edi
	pop esi
	leave
ret
