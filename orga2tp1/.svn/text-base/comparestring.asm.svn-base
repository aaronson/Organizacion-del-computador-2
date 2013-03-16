extern redostring

section .data

global comparestring

%define off_longstr ebp+8
%define off_shortstr ebp+12

section .text

comparestring:
	
	enter 0,0
	push esi
	push edi
	push ebx
  
	push dword [ebp+12]
	call redostring
	add esp, 4
	mov edi, [ebp+8]
	mov esi, eax
	xor ecx, ecx
	xor edx, edx
	
ciclo:
	xor eax, eax
	mov al, [esi]
	cmp al, [edi]
	jne not_equal
	cmp al, '/'
	je equal
	inc esi
	inc edi
	jmp ciclo
	
;ciclo:
	;cmp ecx, 11
	;je equal
	;cmp byte [esi], ' '
	;je espacio
	;cmp byte [edi], '.'
	;je punto
	;xor eax, eax
	;mov al, [esi]
	;cmp al, [edi]
	;jne not_equal
	;xor eax, eax
	;mov al, [edi]
	;cmp al, '/'
	;je equal
	;inc ecx
	;inc edx
	;inc edi
	;inc esi
	;jmp ciclo
	
not_equal:
	;sub edi, ecx
	;sub esi, edx
	xor eax, eax
	jmp fin
	
;espacio:
	;cmp ecx, 8
	;jge espacio_ext
	;cmp byte [edi], '/'
	;je espacio_ext
	;cmp byte [edi], '.'
	;je punto
	;jmp not_equal
	;inc esi
	;inc ecx
	;jmp ciclo
	
;espacio_ext:
	;inc esi
	;inc ecx
	;jmp ciclo
	
;punto:
	;inc edi
	;inc edx
	;jmp ciclo
	
equal:
	xor eax, eax
	inc eax
	inc edi ;saltea la prox /
	;mov esi, ebp
	;add esi, 8
	;mov [esi], edi ;actualiza el puntero al string para quitarle lo recorrido
	mov edx, edi

fin:
	pop ebx
	pop edi
	pop esi
	leave
ret
