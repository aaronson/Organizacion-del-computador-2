global redopath

section .text

redopath:
	enter 0,0
	push esi
	push edi
	push ebx
	
	mov esi, [ebp+8]

ciclo:
	cmp byte [esi], 0
	je agregarslash
	add esi, 1
	jmp ciclo
	
agregarslash:
	mov byte [esi], '/'
	mov byte [esi+1], 0

fin:	
	pop ebx
	pop edi
	pop esi
	leave
ret
