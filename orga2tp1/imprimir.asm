extern printboot
extern open
extern malloc
extern fstat
extern statsize
extern printf
extern mmap
extern munmap
extern close

section .data

	error_msg: db 'No se encuentra la imagen especificada',0
	format: db '%s',10,0
	
global imprimir

%define off_img [ebp +8]


section .text

imprimir: 
	enter 0,0
	push ebx
	push edi
	push esi

	push 0
	push dword off_img
	call open
	add esp, 8
	cmp eax, -1
	je near error
	mov esi, eax
	call statsize
	;add esp, 4
	push eax
	;push 88
	call malloc
	add esp, 4
	mov edi, eax
	push edi
	push esi
	call fstat
	add esp, 8
	add edi, 44
	push dword [edi]
	call malloc
	add esp, 4
	push 0
	push esi
	push 1
	push 1
	push dword [edi]
	push eax
	call mmap
	add esp, 24

; 	push dword off_img
; 	call enterboot
; 	add esp,4

	;mov ebx, eax
	mov ebx, eax
	push ebx
	call printboot
	add esp, 4
	push dword [edi]
	push ebx
	call munmap
	add esp,8
	push esi
	call close
	add esp, 4
	jmp fin
	
error:
	push error_msg
	push format
	call printf
	add esp,8
	;jmp fin

fin:
	pop esi
	pop edi
	pop ebx
	leave
ret
