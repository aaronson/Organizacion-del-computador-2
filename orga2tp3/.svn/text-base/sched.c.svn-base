#include "sched.h"
#include "tss.h"
#include "gdt.h"
#include "mmu.h"
#include "i386.h"

extern void setear_tss (unsigned int gdtpos, unsigned int tsspos, unsigned int cr3, unsigned int stack);

unsigned int prox_free = 0;

unsigned int tarea_actual = 0;

unsigned short tareas[CANT_TAREAS];


void crear_proceso(unsigned int cargar_desde){
	unsigned int* newcr3 = inicializar_dir_usuario();
	unsigned int pagcode = pagina_libre_usuario();
	unsigned int pagstack = pagina_libre_usuario();
	unsigned int temp;
	unsigned int cr3Actual= rcr3();
	
	mapear_pagina (pagstack, (unsigned int) newcr3, pagstack);
	
	mapear_pagina (0, (unsigned int) newcr3, pagcode);
	
	mapear_pagina(pagcode,cr3Actual, pagcode);
	
	unsigned int i;
	
	for (i = 0; i < 1024; i+=4){
		temp = *((unsigned int*)(cargar_desde +i));
		*((unsigned int*)pagcode) = temp;
		pagcode += 4;  
	}
	
	//temp = *newcr3;
	unmapear_pagina(pagcode,cr3Actual);
	
	unsigned int gdtpos = next_free_gdt_entry();
	
	unsigned int tsspos = next_free_tss_entry();
	
	unsigned int x = next_free_tareas();
	
	tareas[x] = gdtpos*8;
		
	setear_tss(gdtpos, tsspos, (unsigned int) newcr3, pagstack);


}

unsigned int next_free_tareas(){
	unsigned int x = prox_free;
	prox_free++;
	return x;
}

unsigned int obtener_pid(){
	//return tarea_actual;
	unsigned short int actual = rtr();
	
	int i;
	
	for (i = 0; i < 16; i++){
		if (tareas[i] == actual){
			return i;
		}
	}
	return i;
}	

unsigned short int proximo_indice(){
	unsigned int x = obtener_pid();
	unsigned short int res;
	//if (x == 16) return tareas[0];
	
	if (x > 15 || tareas[x+1] == 0x00){
		if ( x == 0 ) 
			res = 0; 
		else
			res = tareas [0];
	}else{
		res = tareas[x+1];
	}
	return res;
}

unsigned int proxima_tarea(){
	if (prox_free == tarea_actual){
		return 0;
	}else{
		unsigned int x = obtener_pid();
		unsigned short int res;
		if (x > 15 || tareas[x+1] == 0x00){
			res = 0;
		}else{
			res = x+1;
		}
		return res;
	}
}

void actualizar_prox (unsigned int prox){
	tarea_actual = prox;
}
