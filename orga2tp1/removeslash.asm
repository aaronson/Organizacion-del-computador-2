global removeslash

section .text

removeslash:
	enter 0,0
	push esi
	push edi
	push ebx
	
	mov esi, [ebp+8]

ciclo:
	cmp byte [esi], '/'
	je sacarslash
	add esi, 1
	jmp ciclo
	
sacarslash:
	mov byte [esi], 0
	;mov byte [esi+1], 0

fin:	
	pop ebx
	pop edi
	pop esi
	leave
ret



