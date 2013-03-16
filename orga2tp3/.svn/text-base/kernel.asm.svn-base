BITS 16

%include "macrosmodoreal.mac"



%define KORG 0x1200

global start
extern tsss
extern tareas
extern gdt
extern GDT_DESC
extern IDT_DESC
extern inicializar_idt
extern inicializar_dir_kernel
extern inicializar_dir_usuario
extern pagina_libre_usuario
extern mapear_pagina
extern unmapear_pagina
extern inicializar_mmu
extern tarea_inicial
extern tarea_idle


extern resetear_pic
extern habilitar_pic


;Aca arranca todo, en el primer byte.
start:

	call deshabilitar_A20
	call checkear_A20
	call habilitar_A20
	call checkear_A20

;punto 3
	cli
;punto 4
	lgdt[GDT_DESC]	
;punto 5
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax  ; 16bistseg:32bit

;punto 6
	;xchg bx, bx
	jmp 0x08 : modoProtegido




BITS 32   ;de aca se labura en 32 bits
modoProtegido:
;punto 7
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov gs, ax
	mov fs, ax	
	mov ss, ax
	
	;mov byte[0xb8000],0x60
	;mov byte[0xb8001],0x60

	
;punto 8
	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, mensaje_len 
	mov esi, mensaje
	mov edi, 0 	;a donde queremos q escriba en la pantalla
	mov ah, 0x8A     ;matriz de video (modo , caracter)
cicloprueba:
	lodsb
	stosw
	loop cicloprueba                                                                                                        

int_test:
	;xchg bx, bx
	lidt[IDT_DESC]
	call inicializar_idt
	;mov byte[es:0xFFFFF], 0x40
	;mov eax, 0 ;primera int 
	;mov edx, 0
	;div edx
	
;xchg bx, bx

	mov ax, 0x18 ;descriptor de video
	mov es, ax
	mov ecx, 80*25
	mov ax, 0x2000
	xor bx, bx
	;mov esi, mensaje
	;mov edi, 0 	;a donde queremos q escriba en la pantalla
	;mov ah, 0x8A     ;matriz de video (modo , caracter)
	;mov al, 0x00
cicloborrar:
	mov [es:bx], ax
	add bx, 2
	loop cicloborrar

paginacion:
	call inicializar_mmu
	call inicializar_dir_kernel
	mov cr3, eax
	mov eax, cr0
	or eax, 0x80000000
	mov cr0, eax
	
	mov eax, 0x18
	mov es, ax
	
	mov ah, 0x1a
	mov ecx, mensajepag_len
	mov esi, mensajepag
	mov edi, 0
	


ciclomensaje:
	lodsb
	stosw
	loop ciclomensaje
	
;xchg bx,bx			

mapear:

	mov ebx, cr3
	call inicializar_dir_usuario
	mov esi, eax

	;mov eax, cr3
	push dword 0xb8000 ; fisica
	push eax
	push dword 0x500000 ; virtual
	call mapear_pagina
	add esp, 12	
	
	mov eax, esi
	
	mov cr3, eax
	xor eax, eax
	mov ah, 0x37
	mov al, 0x57
	mov edi, 0x500000
	mov word [edi], ax
	;xchg bx, bx
	mov cr3, ebx
	;push dword 0x500000 ; fisica
	;push eax
	;push dword 0x400000 ; virtual
	;call mapear_pagina
	;add esp, 12	
	
	
;xchg bx,bx

	
	mov eax, cr3
	push eax
	push dword 0x500000 ; virtual
	call unmapear_pagina
	add esp,4
	
;xchg bx,bx

interrupts:
	call resetear_pic
	call habilitar_pic
	sti

lastareas:
	;xchg bx, bx
; inicial
	mov edi,tarea_inicial
	;add edi,104*0
	
	mov esi, gdt
	add esi, 0x20
	mov word [esi], 0x67
	mov word [esi+2],di
	mov edx, edi
	shr edx, 16
	mov byte [esi+4], dl
	mov byte [esi+5], 10001001b
	mov byte [esi+6], 00010000b
	mov byte [esi+7], dh

; idle
	;call inicializar_dir_usuario
	;mov ebx, eax
	call pagina_libre_usuario
	mov edx, eax
	add edx, 0x1000
	;mov eax, cr3
	;push edx
	;push eax
	;push ebx
	;call mapear_pagina
	;add esp, 12
	mov edi,tarea_idle
	;add edi,104*1
	mov eax,cr3
	mov [edi+28],eax
	mov dword [edi+32],0x12000
	mov dword [edi+36],0x202
	mov dword [edi+56],edx
	mov dword [edi+60],edx
	mov word [edi+72],0x10;<seg.dat>
	mov word [edi+76],0x8;<seg.cod>
	mov word [edi+80],0x10;<seg.dat>
	mov word [edi+84],0x10;<seg.dat>
	mov word [edi+88],0x10;<seg.dat>
	mov word [edi+92],0x10;<seg.dat>
	mov word [edi+102],0xFFFF
	
	mov esi, gdt
	add esi, 0x28
	mov word [esi], 0x67
	mov word [esi+2],di
	mov edx, edi
	shr edx, 16
	mov byte [esi+4], dl
	mov byte [esi+5], 10001001b
	mov byte [esi+6], 00010000b
	mov byte [esi+7], dh


	;cargar el registro de tarea
	mov ax, 0x20
	ltr ax
	
	;mov esi, [tareas]
	;mov word [esi], 0x20
	;add esi, 2
	;mov word [esi], 0x28
		
	;saltar a la tarea idle
	jmp 0x28:0



	jmp $
			
			
			
			



mensajepag: db 'When I was a child, I caught a fleeting glimpse, out of the corner of my eye. I turned to look but it was gone; I cannot put my finger on it, now, the child has grown, the dream is gone, I have become comfortably numb',0
mensajepag_len: equ $-mensajepag

	

mensaje: db"mensaje de prueba"
mensaje_len: equ $-mensaje


%include "a20.asm"

