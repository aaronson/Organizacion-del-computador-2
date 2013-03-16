extern malloc

section .data

global redostring

section .text

redostring:
		
	enter 0,0
	push ebx
	push esi
	push edi
	
	mov esi, [ebp+8]
	push 3
	call malloc
	add esp, 4
	mov edi, eax
	xor ecx, ecx
	
ciclo:
	cmp ecx, 11
	je terminar
	cmp ecx, 8
	je agregar_punto
ciclo2:
	cmp byte [esi], ' '
	je saltear
	xor edx, edx
	mov dl, byte [esi]
	mov byte[edi], dl
	inc esi
	inc edi
	inc ecx
	jmp ciclo
	

saltear:
	inc esi
	inc ecx
	jmp ciclo
	
agregar_punto:
	mov byte [edi], '.'
	inc edi
	jmp ciclo2
	
sacar_punto:
	jmp fin
	
terminar:
	dec edi
	cmp byte [edi], '.'
	je sacar_punto
	inc edi
fin:
	mov byte [edi], '/'
	pop edi
	pop esi
	pop ebx
	leave
ret
