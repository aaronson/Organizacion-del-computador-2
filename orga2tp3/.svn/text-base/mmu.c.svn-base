#include "mmu.h"
#include "i386.h"

unsigned int* inicializar_dir_kernel(){
	unsigned int base = 0;
	unsigned int* dirbase = (unsigned int*) 0x00100000;
	unsigned int* tablebase = (unsigned int*) 0x00101000;
	*dirbase = ((unsigned int) tablebase | 3);
	for (base = 0; base < 0x3FFFFF; base += TAMANO_PAGINA){
		*tablebase = (base | 3);
		tablebase++;
	}
	return dirbase; 	
}

void inicializar_mmu(){
	nf_kernel = 0x102000;
	nf_user = 0x200000;
}

unsigned int pagina_libre_usuario (){
	int i = nf_user;
	nf_user += 0x1000;
	return i;
}

unsigned int pagina_libre_kernel (){
	int i = nf_kernel;
	nf_kernel += 0x1000;
	return i;
}

unsigned int* inicializar_dir_usuario(){
	unsigned int base = 0;
	unsigned int* dirbase = (unsigned int*) pagina_libre_kernel();
	int i;
	for (i = 1; i < 1024; i++) {
		*(dirbase + i) = 0;
	}
	
	unsigned int* tablebase = (unsigned int*) pagina_libre_kernel();
	*dirbase = ((unsigned int) tablebase | 3);
	for (base = 0; base < 0x1FFFFF; base += TAMANO_PAGINA){
		*tablebase = (base | 3);
		tablebase++;
	}
	for (base = 0x200000; base < 0x3FFFFF; base += TAMANO_PAGINA){
		*tablebase = 0;
		tablebase++;
	}
	return dirbase;	
}

void mapear_pagina(unsigned int virtual, unsigned int cr3, unsigned int fisica) {

	unsigned int index_pd;
	unsigned int index_pt;
	
	unsigned int entrada_pd; 
	unsigned int entrada_pt;
	unsigned int dirbase;
	unsigned int i;
	index_pd = (virtual >> 22);
	index_pt = (virtual >> 12) & 0x3FF;
	
	entrada_pd = (cr3 & ~0xFFF) + index_pd * 4 ; 
	
	if (!(*((unsigned int*)entrada_pd) & 0x2)){
		
		dirbase = pagina_libre_kernel();

		for (i = dirbase; i < dirbase + 4096; i=i+4) {
			*((unsigned int*)i) = 0;
		}

	*((unsigned int*)entrada_pd) = (dirbase & ~0xFFF) | 3;
	}
	
	entrada_pt = (*((unsigned int *)entrada_pd) & ~0xFFF) + index_pt *4;
	
	*((unsigned int *)entrada_pt) = (fisica & ~0xFFF) | 3;

}

void unmapear_pagina(unsigned int virtual, unsigned int cr3) {
	unsigned int index_pd;
	unsigned int index_pt;
	
	unsigned int entrada_pd; 
	unsigned int entrada_pt;
	
	index_pd = (virtual >> 22);
	index_pt = (virtual >> 12) & 0x3FF;
	
	entrada_pd = (cr3 & ~0xFFF) + index_pd * 4 ; 
	
	entrada_pt = (*((unsigned int *)entrada_pd) & ~0xFFF) + index_pt *4;
	
	*((unsigned int *)entrada_pt) = 0;
}
