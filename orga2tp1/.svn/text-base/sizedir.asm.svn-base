extern printf
extern calcsize
extern printsize
extern open
extern malloc
extern fstat
extern statsize
extern mmap
extern munmap
extern close
extern comparestring

section .data

	size_cluster: dd 0x00000000
	reserved: dd 0x00000000
	cant_fat: dd 0x00000000
	size_fat: dd 0x00000000
	size_sec: dd 0x00000000
	fat_addr: dd 0x00000000
	boot_addr: dd 0x00000000
	root_addr: dd 0x00000000
	root_entries: dd 0x00000000
	error_msg: db 'No se encuentra el directorio especificado',0
	format: db '%s',10,0
	size_img: dd 0x00000000
	filedes: dd 0x00000000
	no_next: dw 0xfff8


global sizedir

%define off_img [ebp +12]
%define off_dir [ebp +8]

section .text

sizedir:
	enter 0,0
	push edi
	push esi
	push ebx

	push 0
	push dword off_img
	call open
	add esp, 8
	mov [filedes], eax
	call statsize
	;add esp, 4
	push eax
	;push 88
	call malloc
	add esp, 4
	mov edi, eax
	push edi
	push dword [filedes]
	call fstat
	add esp, 8
	add edi, 44
	mov eax, [edi]
	mov [size_img], eax
	push dword [size_img]
	call malloc
	add esp, 4
	push 0
	push dword [filedes]
	push 1
	push 1
	push dword [size_img]
	push eax
	call mmap
	add esp, 24
	mov ebx, eax

	mov esi, off_dir
	mov dword [boot_addr], ebx
	
	xor eax, eax
	xor ecx, ecx
	mov ax, [ebx+11]
	mov dword [size_sec], eax
	mov cl, [ebx+13]
	mul ecx
	mov dword [size_cluster], eax
	xor ecx, ecx
	mov cx, [ebx+14]
	mov dword [reserved], ecx
	xor ecx, ecx
	mov cl, [ebx+16]
	mov dword [cant_fat], ecx
	xor eax, eax
	xor ecx, ecx
	mov ax, [ebx+17]
	mov ecx, 32
	mul ecx
	mov dword [root_entries], eax
	xor eax, eax
	xor ecx, ecx
	mov ax, [ebx+11]
	mov cx, [ebx+22]
	mul cx
	mov dword [size_fat], eax

	add ebx, 512 ;pone en reservados
	xor ecx, ecx
	xor eax, eax
	mov ecx, [size_sec]
	mov eax, [reserved]
	dec eax
	mul ecx
	add ebx, eax ;pone en FAT
	mov dword [fat_addr],ebx
	xor eax, eax
	mov eax, [cant_fat]
	mov ecx, [size_fat]
	mul ecx
	add ebx, eax ;pone en root
	mov [root_addr], ebx
;
	inc esi
traverseroot:
	mov edi, no_next
	;xor edx, edx
	;mov edx, esi
	cmp byte [esi], 0
	je near calculardir
	xor eax, eax
	mov al, [ebx]
	cmp al, 0x20
	je near avanzar_root
	cmp al, 0xe5
	je near avanzar_root
	cmp al, 0x00
	je near no_encontrado
	xor ecx, ecx
	mov cl, [ebx+11]
	cmp cl, 0x0f
	je near avanzar_root
	and cl,0x10
	jz near avanzar_root
	push ebx
	push esi
	call comparestring
	add esp, 8
	cmp eax, 0  
	je near avanzar_root
	mov esi, edx
	xor eax, eax
	mov ax, [ebx+26]
	;xor edi, edi
	mov edi, eax
	sub ax, 2
	mov edx, 2048
	mul edx
; 	mul word [size_cluster]
	mov ebx, [root_addr]
	add ebx, [root_entries]
	add ebx, eax
	;add edi, dword [fat_addr]
	mov edx, edi
	add edx, edx ;multiplico por 2 para pasar de words a bytes
	mov edi, [fat_addr]
	;add edi, 
	;add edi, edx
	;xor edx, edx
	add edi, edx
	mov dx, [edi]
	cmp byte [esi], 0
	je near calculardir
	jmp traversedir

avanzar_root: 
	add ebx, 32
	jmp traverseroot
	
traversedir:
	;xor edx, edx
	;mov edx, esi
	cmp byte [esi], 0
	je near calculardir
	xor eax, eax
	mov al, [ebx]
	cmp al, 0x20
	je near avanzar
	cmp al, 0xe5
	je near avanzar
	cmp al, 0x00
	je near fin_cluster_trav
	xor ecx, ecx
	mov cl, [ebx+11]
	cmp cl, 0x0f
	je near avanzar
	and cl,0x10
	jz near avanzar
	push ebx
	push esi
	call comparestring
	add esp, 8
	cmp eax, 0  
	je avanzar
	mov esi, edx
	xor eax, eax
	mov ax, [ebx+26]
	mov edi, eax
	sub ax, 2
	mov edx, 2048
	mul edx
; 	mul word [size_cluster]
	;add edi, [fat_addr]
	mov ebx, [root_addr]
	add ebx, [root_entries]
	add ebx, eax
	mov edx, edi
	add edx, edx ;multiplico por 2 para pasar de words a bytes
	mov edi, [fat_addr]
	;add edi, 
	;add edi, edx
	;xor edx, edx
	add edi, edx
	cmp byte [esi], 0
	je calculardir
	jmp traversedir
	
fin_cluster_trav:
	;xor eax, eax
	;mov ax, [ebx+26]
	;mov edx, eax
	;mov edi, edx
	;add edi, edi
	;add edi, [fat_addr]
	xor edx, edx
	mov dx, [edi]
	cmp edx, 0xfff8
	jge near fin
	xor eax, eax
	mov ax, [edi]
	sub ax, 2
	mov edx, 2048
	mul edx
	;mul word [size_cluster]
	;add edi, [fat_addr]
	mov ebx, [root_addr]
	add ebx, [root_entries]
	add ebx, eax
	xor edx, edx
	mov dx, [edi]
	add edx, edx ;multiplico por 2 para pasar de words a bytes
	mov edi, [fat_addr]
	;add edi, 
	;add edi, edx
	;xor edx, edx
	add edi, edx
	jmp near traversedir

avanzar:
	add ebx, 32
	jmp traversedir
	
no_encontrado:
	push error_msg
	push format
	call printf
	add esp,8
	jmp fin

calculardir:
	push dword [fat_addr]
	xor edx, edx
	mov dx, [edi]
	push edx
	push dword 2048
	push dword [root_addr]
	push dword [root_entries]
	push ebx
	call calcsize
	add esp, 24
	jmp imprimirsize
	
imprimirsize:
	push eax
	call printsize
	add esp, 4

fin:

	push dword [size_img]
	push dword [boot_addr]
	call munmap
	add esp, 8
	push dword[filedes]
	call close
	add esp, 4

	pop ebx
	pop esi
	pop edi
	leave
ret
	
