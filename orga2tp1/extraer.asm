extern open
extern malloc
extern fstat
extern statsize
extern printf
extern mmap
extern write
extern comparestring
extern close
extern createname
extern munmap
extern removeslash
extern redopath

section .data

	size_cluster: dd 0x00000000
	reserved: dd 0x00000000
	cant_fat: dd 0x00000000
	size_fat: dd 0x00000000
	fat_addr: dd 0x00000000
	size_sec: dd 0x00000000
	boot_addr: dd 0x00000000
	root_addr: dd 0x00000000
	root_entries: dd 0x00000000
	filedes_img: dd 0x00000000
	error_msg: db 'No se encuentra el archivo especificado',0
	format: db '%s',10,0
	filename: db 'BBBBBBBB.TXT',0
	filedes_file: dd 0x00000000
	cluster_actual: dd 0x00000000
	size_img: dd 0x00000000
	no_next: dw 0xfff8


global extraer

%define off_img [ebp +12]
%define off_file [ebp +8]

section .text

extraer:
	enter 0,0
	push ebx
	push edi
	push esi

	push 0
	push dword off_img
	call open
	add esp, 8
	cmp eax, -1
	je near fin
	mov [filedes_img], eax
	mov esi, eax
	call statsize
	;add esp, 4
	push eax
	;push 88
	call malloc
	add esp, 4
	mov edi, eax
	push edi
	push dword [filedes_img]
	call fstat
	add esp, 8
	add edi, 44
	mov eax, [edi]
	mov [size_img], eax
	push dword [size_img]
	call malloc
	add esp, 4
	push 0
	push dword [filedes_img]
	push 1
	push 1
	push dword [size_img]
	push eax
	call mmap
	add esp, 24
	mov ebx, eax
	mov esi, off_file
	push esi
	call redopath
	add esp, 4
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
	mov dword [fat_addr], ebx
	xor eax, eax
	mov eax, [cant_fat]
	mov ecx, [size_fat]
	mul ecx
	add ebx, eax ;pone en root
	mov [root_addr], ebx
	inc esi ;saca la primera /

traverseroot:
	mov edi, no_next
	;xor edx, edx
	;mov edx, esi
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
	push ebx
	push esi
	call comparestring
	add esp, 8
	cmp eax, 0  
	je near avanzar_root
	xor ecx, ecx
	mov cl, [ebx+11]
	and cl, 0x10
	je near extraerfile
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
	jmp traversedir
	
avanzar_root: 
	add ebx, 32
	jmp traverseroot

traversedir:
	cmp byte [esi], 0
	je near extraerfile
	xor eax, eax
	mov al, [ebx]
	cmp al, 0x20
	je avanzar
	cmp al, 0xe5
	je avanzar
	cmp al, 0x00
	je near fin_cluster_trav
	xor ecx, ecx
	mov cl, [ebx+11]
	cmp cl, 0x0f
	je avanzar
	push ebx
	push esi
	call comparestring
	add esp, 8
	cmp eax, 0  
	je avanzar
	xor ecx, ecx
	mov cl, [ebx+11]
	and cl, 0x10
	je near extraerfile
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
	jmp traversedir
	
avanzar:
	add ebx, 32
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
	jge no_encontrado
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

no_encontrado:
	push error_msg
	push format
	call printf
	add esp,8
	jmp fin

extraerfile:
	push esi
	call removeslash
	;call createname
	add esp, 4
	push 0x1c0
	push 0x42
	push esi
	;push dword filename
	call open
	add esp, 12
	mov dword [filedes_file], eax
	mov edi, [ebx+28]
	;cmp ecx, [size_cluster]
	;jg writefin
	;jmp writecluster
	xor ecx, ecx
	mov cx, [ebx+26]
	mov eax, ecx
	sub ax, 2
	mov edx, 2048
	mul edx
	mov ebx, [root_addr]
	add ebx, [root_entries]
	add ebx, eax
	mov edx, [fat_addr]
	add edx, ecx
	add edx, ecx
	;xor esi, esi
	xor ecx, ecx
	mov cx, word [edx]
	mov word [cluster_actual], cx
	;cmp word [cluster_actual], 0xfff8
	;je writefin
	;cmp cx, 0xffff
	;je writefin
	cmp edi, 2048
	jle writefin
	jmp writecluster
; 
; 
; 
writefin:
	
	push edi
	push ebx
	push dword [filedes_file]
	call write
	add esp, 12
	jmp fin
	
writecluster:
	mov esi, ecx
	push 2048
	push ebx
	push dword [filedes_file]
	call write
	add esp, 12
	sub edi, [size_cluster]
	xor eax, eax
	mov eax, esi
	sub eax, 2
	mov edx, 2048
	mul edx
	mov ebx, [root_addr]
	add ebx, [root_entries]
	add ebx, eax
	mov edx, [fat_addr]
	add edx, [cluster_actual]
	add edx, [cluster_actual]
	xor ecx, ecx
	mov cx, word [edx]
	mov word [cluster_actual], cx
	;cmp cx, 0xfff8
	;je writefin
	;cmp cx, 0xffff
	;je writefin
	cmp edi, 2048
	jle writefin
	jmp writecluster
	
	
	
fin:	
	push dword [filedes_file]
	call close
	add esp, 4
	push dword [size_img]
	push dword [boot_addr]
	call munmap
	add esp, 8
	push dword [filedes_img]
	call close
	add esp, 4
	pop esi
	pop edi
	pop ebx
	leave
ret
