#include "gdt.h"
#include "tss.h"

unsigned int nf_gdt = 6;

gdt_entry gdt[GDT_COUNT] = {
	/* Descriptor nulo*/
	(gdt_entry){(unsigned int) 0x00000000, (unsigned int) 0x00000000 },
	(gdt_entry){
	(unsigned short) 0xFFFF, //empieza
	(unsigned short) 0,
	(unsigned char)	0,
	(unsigned char) 0xA,
	(unsigned char) 1,
	(unsigned char) 0,
	(unsigned char) 1,
	(unsigned char) 0xF,
	(unsigned char) 0,
	(unsigned char) 0,
	(unsigned char) 1,
	(unsigned char) 1,
	(unsigned char) 0 },
	(gdt_entry){
	(unsigned short) 0xFFFF, //empieza
	(unsigned short) 0,
	(unsigned char)	0,
	(unsigned char) 0x2,
	(unsigned char) 1,
	(unsigned char) 0,
	(unsigned char) 1,
	(unsigned char) 0xF,
	(unsigned char) 0,
	(unsigned char) 0,
	(unsigned char) 1,
	(unsigned char) 1,
	(unsigned char) 0 },
	(gdt_entry){
	(unsigned short) 0xF9F, //empieza
	(unsigned short) 0x8000,
	(unsigned char)	0x0B,
	(unsigned char) 0x2,
	(unsigned char) 1,
	(unsigned char) 0,
	(unsigned char) 1,
	(unsigned char) 0,
	(unsigned char) 0,
	(unsigned char) 1,
	(unsigned char) 0,
	(unsigned char) 0,
	(unsigned char) 0 }
	


	
};

gdt_descriptor GDT_DESC = {sizeof(gdt)-1, (unsigned int)&gdt};

unsigned int next_free_gdt_entry (){
	int x = nf_gdt;
	nf_gdt++;
	return x;
}
