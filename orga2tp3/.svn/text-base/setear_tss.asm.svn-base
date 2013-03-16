
extern gdt
extern tsss

global setear_tss
	
setear_tss:
	enter 0,0
	push edi
	push esi
	push ebx
	;xchg bx, bx
	mov eax, [ebp+12]
	mov edx, 104
	mul edx
	mov edx, [ebp+20]
	add edx, 0x1000
	;mov eax, cr3
	;push edx
	;push eax
	;push ebx
	;call mapear_pagina
	;add esp, 12
	mov edi,tsss
	add edi,eax
	mov eax,[ebp+16]
	mov [edi+28],eax
	mov dword [edi+32],0x0
	mov dword [edi+36],0x202
	mov dword [edi+56],edx
	mov dword [edi+60],edx
	mov word [edi+72],0x18;<seg.dat>
	mov word [edi+76],0x8;<seg.cod>
	mov word [edi+80],0x10;<seg.dat>
	mov word [edi+84],0x10;<seg.dat>
	mov word [edi+88],0x10;<seg.dat>
	mov word [edi+92],0x10;<seg.dat>
	mov word [edi+102],0xFFFF
	
	;mov edi,tsss
	;add edi,104*1
	;mov eax,cr3
	;mov [edi+28],eax
	;mov dword [edi+32],0x12000
	;mov dword [edi+36],0x202
	;mov dword [edi+56],edx
	;mov dword [edi+60],edx
	;mov word [edi+72],0x10;<seg.dat>
	;mov word [edi+76],0x8;<seg.cod>
	;mov word [edi+80],0x10;<seg.dat>
	;mov word [edi+84],0x10;<seg.dat>
	;mov word [edi+88],0x10;<seg.dat>
	;mov word [edi+92],0x10;<seg.dat>
	;mov word [edi+102],0xFFFF
	
	mov esi, gdt
	mov eax, [ebp+8]
	shl eax, 3
	;mov edx, 8
	;mul edx
	add esi, eax
	mov word [esi], 0x67
	mov word [esi+2],di
	mov edx, edi
	shr edx, 16
	mov byte [esi+4], dl
	mov byte [esi+5], 10001001b
	mov byte [esi+6], 00010000b
	mov byte [esi+7], dh
	
	pop ebx
	pop esi
	pop edi
	leave
ret
	
