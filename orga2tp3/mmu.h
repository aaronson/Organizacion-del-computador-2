#ifndef __MMU_H__
#define __MMU_H__

#define INICIO_PAGINAS_KERNEL 	0x00100000
#define INICIO_PAGINAS_USUARIO	0x00200000
#define TAMANO_PAGINA 			0x1000

unsigned int* inicializar_dir_kernel();
void mapear_pagina(unsigned int virtual, unsigned int cr3, unsigned int fisica);
unsigned int* inicializar_dir_usuario();
void unmapear_pagina(unsigned int virtual, unsigned int cr3);
unsigned int pagina_libre_usuario ();
unsigned int pagina_libre_kernel ();


unsigned int nf_kernel;
unsigned int nf_user;


#endif
