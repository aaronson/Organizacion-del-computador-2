BITS 32
%include "macrosmodoprotegido.mac"

extern fin_intr_pic1
extern obtener_pid
extern proximo_indice
extern proxima_tarea
extern actualizar_prox
extern crear_proceso

temp: dd 0
offset: dd 0
selector: dw 0


global _isr0
_isr0:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr0len
	mov esi, isr0mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x7B     ;matriz de video (modo , caracter)
ciclo0:
	lodsb
	stosw
	loop ciclo0
	;jmp $
	iret
	
global _isr1
_isr1:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr1len
	mov esi, isr1mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo1:
	lodsb
	stosw
	loop ciclo1
	iret
	
global _isr2
_isr2:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr2len
	mov esi, isr2mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo2:
	lodsb
	stosw
	loop ciclo2
	iret
	
global _isr3
_isr3:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr3len
	mov esi, isr3mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo3:
	lodsb
	stosw
	loop ciclo3
	iret
	
global _isr4
_isr4:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr4len
	mov esi, isr4mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo4:
	lodsb
	stosw
	loop ciclo4
	iret

global _isr5
_isr5:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr5len
	mov esi, isr5mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo5:
	lodsb
	stosw
	loop ciclo5
	iret
	
global _isr6
_isr6:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr6len
	mov esi, isr6mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo6:
	lodsb
	stosw
	loop ciclo6
	iret
	
global _isr7
_isr7:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr7len
	mov esi, isr7mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo7:
	lodsb
	stosw
	loop ciclo7
	iret

global _isr8
_isr8:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr8len
	mov esi, isr8mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo8:
	lodsb
	stosw
	loop ciclo8
	iret
	
global _isr9
_isr9:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr9len
	mov esi, isr9mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo9:
	lodsb
	stosw
	loop ciclo9
	iret

global _isr10
_isr10:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr10len
	mov esi, isr10mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo10:
	lodsb
	stosw
	loop ciclo10
	iret

global _isr11
_isr11:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr11len
	mov esi, isr11mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo11:
	lodsb
	stosw
	loop ciclo11
	iret

global _isr12
_isr12:
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr12len
	mov esi, isr12mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo12:
	lodsb
	stosw
	loop ciclo12
	iret
	

global _isr13
_isr13:
	;xchg bx, bx
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr13len
	mov esi, isr13mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo13:
	lodsb
	stosw
	loop ciclo13
	iret


global _isr14
_isr14:
	xchg bx, bx
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, isr14len
	mov esi, isr14mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
ciclo14:
	lodsb
	stosw
	loop ciclo14
	iret

global _isr32
_isr32:
	cli
	pushad
	inc DWORD [isrnumero]
	mov ebx, [isrnumero]
	cmp ebx, 0x4
	jl .ok
		mov DWORD [isrnumero], 0x0
		mov ebx, 0
	.ok:
		add ebx, isrmensaje1
		mov edx, isrmensaje
		IMPRIMIR_TEXTO edx, 6, 0x0A, 24, 73
		IMPRIMIR_TEXTO ebx, 1, 0x0A, 24, 79
	call fin_intr_pic1
	;xchg bx, bx
	;nop
	call proximo_indice
	cmp eax, 0 
	je seguir
	;call proxima_tarea
	;mov esi, eax
	;call obtener_pid
	;cmp esi, eax
	;je seguir
	;call proximo_indice
	mov bx, ax
	;push esi
	;call actualizar_prox
	;add esp, 4
	;shl ebx, 3
	;xchg bx, bx	
	
	mov [selector], bx
	jmp far [offset]
	
seguir:	
	
	popad
	sti
	iret

global _isr33
_isr33:
	;xchg bx, bx
	cli
	pushad
	xor eax, eax
	in al, 0x60
	cmp al, 0x80
	ja near fin
	cmp al, 0x0B
	ja near fin
	cmp al, 0x02
	jb near fin
	cmp al, 0x0B
	je imprimir_zero
	cmp al, 0x0A
	je imprimir_nueve
	;add al, 0x2F
	;mov [aimprimir], al
	;mov ebx, aimprimir
	;IMPRIMIR_TEXTO ebx, 1, 0x0A, 24, 35
	dec al
	dec al
	shl eax, 12
	add eax, 0x13000
	push eax
	;xchg bx, bx
	call crear_proceso
	;xchg bx, bx
	add esp, 4
	jmp fin

imprimir_zero:
	mov al, 0x30
	mov [aimprimir], al
	mov ebx, aimprimir
	IMPRIMIR_TEXTO ebx, 1, 0x0A, 24, 35
	jmp fin
	
imprimir_nueve:
	add al, 0x2F
	mov [aimprimir], al
	mov ebx, aimprimir
	IMPRIMIR_TEXTO ebx, 1, 0x0A, 24, 35

fin:	
	call fin_intr_pic1
	popad
	sti
	iret
	
global _isr88
_isr88:
	cli
	xchg bx, bx
	pushad
	call obtener_pid
	mov [temp], eax
	call fin_intr_pic1
	popad
	mov eax, [temp]
	sti
	iret

global _isr89
_isr89:
	cli
	xchg bx,bx
	pushad
	call fin_intr_pic1
	popad
	mov eax, 64
	;IMPRIMIR_TEXTO eax, 25, 0x0A, 12, 40
	sti
	iret


	


	
isrmensaje: db 'Clock:'
isrnumero: dd 0x00000000
isrmensaje1: db '|'
isrmensaje2: db '/'
isrmensaje3: db '-'
isrmensaje4: db '\'






isr0mensaje: db"Divide Error Fault, formatting hard drive now, please wait...",10,0
isr0len: equ $-isr0mensaje
isr1mensaje: db"Reserved Fault, your code sucks",10,0
isr1len: equ $-isr1mensaje
isr2mensaje: db"NMI Interrupt, your code sucks",0
isr2len: equ $-isr2mensaje
isr3mensaje: db"Breakpoint Fault, your code sucks",0
isr3len: equ $-isr3mensaje
isr4mensaje: db"Overflow, your code sucks",0
isr4len: equ $-isr4mensaje
isr5mensaje: db"Bound Range Excedeed, your code sucks",0
isr5len: equ $-isr5mensaje
isr6mensaje: db"Invalid opcode, your code sucks",0
isr6len: equ $-isr6mensaje
isr7mensaje: db"Device not available, your code sucks",0
isr7len: equ $-isr7mensaje
isr8mensaje: db"Double Fault, Federer to serve",0
isr8len: equ $-isr8mensaje
isr9mensaje: db"Coprocessor Segment Overrun, your code sucks",0
isr9len: equ $-isr9mensaje
isr10mensaje: db"Invalid TSS, your code sucks",0
isr10len: equ $-isr10mensaje
isr11mensaje: db"Segment Not Present, your code sucks",0
isr11len: equ $-isr11mensaje
isr12mensaje: db"Stack-Segment Fault, your code sucks",0
isr12len: equ $-isr12mensaje
isr13mensaje: db"General Protection Fault, your code sucks",10,0
isr13len: equ $-isr13mensaje
isr14mensaje: db"Page Fault, your code sucks and this is interrupt no.14",0
isr14len: equ $-isr14mensaje
grupo: db"Grupo Pink Floyd The Wall",0


aimprimir: db 0



