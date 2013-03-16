section .data

	;next_cluster: dw 0xfff8

global calcsize

%define fat_addr [ebp+28]
%define next_cluster [ebp+24]
%define size_cluster [ebp +20]
%define root_addr [ebp +16]
%define root_entries [ebp +12]
%define off_pointer [ebp +8]

section .text

calcsize:

	enter 0,0
	push esi
	push edi
	push ebx
	
	mov ebx, off_pointer
	xor edi, edi
	xor ecx, ecx
	xor edx, edx
	;mov eax, nc_address
	;mov dx, [eax]
	;mov [next_cluster], dx

ciclodir:
	;mov edx, root_entries
	;mov edx, root_addr
	cmp ecx, 2048
	jge near fin_cluster_ciclo
	xor edx, edx
	mov dl, [ebx]
	;jecxz fin_cluster_ciclo
	cmp dl, 0x20
	je near avanzar
	cmp dl, 0xe5
	je near avanzar
	cmp dl, 0x2e ;como solo . y .. empiezan con punto, los descartamos para el calculo
	je near avanzar
	xor edx, edx
	mov dl, [ebx+11]
	cmp dl, 0x0f
	je near avanzar
	and dl, 0x10
	jz near archivo
	jmp directorio
	
fin_cluster_ciclo:
	xor edx, edx
	mov edx, next_cluster
	cmp edx, 0xfff8
	je near fin
	cmp edx, 0xffff
	je near fin
	;xor eax, eax
	mov eax, next_cluster
	sub ax, 2
	mov edx, 2048
	mul edx
	;mul word [size_cluster]
	;add edi, [fat_addr]
	mov ebx, root_addr
	add ebx, root_entries
	add ebx, eax
	xor edx, edx
	mov edx, next_cluster
	add edx, edx ;multiplico por 2 para pasar de words a bytes
	mov esi, fat_addr
	;add edi, 
	;add edi, edx
	;xor edx, edx
	add esi, edx
	xor edx, edx
	mov dx, [esi]
	mov next_cluster, edx
	xor ecx, ecx
	jmp ciclodir
	
	
archivo:
	add edi, dword [ebx+28]
	jmp avanzar

directorio:
	mov esi, ebx
	xor eax, eax
	mov ax, [ebx+26]
	sub ax, 2
	mov edx, size_cluster
	mul edx
	mov ebx, root_addr
	add ebx, root_entries
	add ebx, eax
	push ecx
	push dword fat_addr
	;push dword next_cluster
	xor edx, edx
	mov dx, [esi+26]
	add edx, edx
	mov eax, fat_addr
	add eax, edx
	xor edx, edx
	mov dx, [eax]
	push edx
	push dword size_cluster
	push dword root_addr
	push dword root_entries
	push ebx
	call calcsize
	add esp, 24
	pop ecx
	add edi, eax
	mov ebx, esi
	jmp avanzar
	
avanzar:	
	add ebx, 32
	add ecx, 32
	jmp ciclodir
	
	  
fin:
	mov eax, edi
	pop ebx
	pop edi
	pop esi
	leave
ret
