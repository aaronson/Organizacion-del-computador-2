#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>

typedef struct booty
{
	char fstbtyes[3];
	//char sndbyte
	//char trdbyte
	char oem[8];
	unsigned short int bytepersec;
	unsigned char secperclus;
	unsigned short int ressec;
	unsigned char fatnum;
	unsigned short int rootentries;
	unsigned short int secinvol;
	unsigned char mdt;
	unsigned short int secperfat;
	unsigned short int secperpista;
	unsigned short int cabezas;
	unsigned int hidden;
	unsigned int secmedium;
	unsigned char discnumber;
	unsigned char reserved;
	unsigned char signature;
	unsigned int volumeid;
	char vollabel[11];
	char idsystem[8];
	char bootcode [448];
	unsigned short int partitionsign;

}__attribute__((packed)) booty;

void printboot (struct booty* varboot){
	//printf("Primeros 3 bytes: %.3s\n", varboot->fstbtyes);
	printf("Identificador OEM: %.8s\n", varboot->oem);
	printf("Bytes por sector: %u\n", varboot->bytepersec);
	printf("Sectores por cluster: %u\n", varboot->secperclus);
	printf("Sectores reservados: %u\n", varboot->ressec);
	printf("Número de FATs: %u\n", varboot->fatnum);
	printf("Número de entradas en el root: %u\n", varboot->rootentries);
	printf("Número total de sectores: %u\n", varboot->secinvol);
	printf("Media Descriptor Type: %u\n", varboot->mdt);
	printf("Número de sectores por FAT: %u\n", varboot->secperfat);
	printf("Número de sectores por pista: %u\n", varboot->secperpista);
	printf("Número de cabezas: %u\n", varboot->cabezas);
	printf("Número de sectores ocultos: %u\n", varboot->hidden);
	printf("Número de sectores en el medio: %u\n", varboot->secmedium);
	printf("Número de disco: %u\n", varboot->discnumber);
	printf("Firma: %X\n", varboot->signature);
	printf("Número de serie del volumen: %X\n", varboot->volumeid);
	printf("Etiqueta del volumen: %.11s\n", varboot->vollabel);
	printf("Identificador del sistema: %.8s\n", varboot->idsystem);
	//printf("Código de Booteo: %s\n", varboot->bootcode);
	printf("Firma de partición: 0x%X", varboot->partitionsign);









}
