#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>

typedef struct file
{
	char name[8];
	char ext[3];
	unsigned char attrib;
	unsigned char reserved;
	unsigned char tenths;
	unsigned short int creation_time;
	unsigned short int creation_date;
	unsigned short int last_access;
	unsigned short int zero;
	unsigned short int modified_date;
	unsigned short int modified_time;
	unsigned short int cluster;
	unsigned int size;
}__attribute__((packed)) file;

void printdir (struct file* varfile, int isdir){
	if (isdir == 1) {
		printf("[");
	}
	printf("%.8s", varfile->name);
	if (varfile->ext[0] != ' '){
	printf(".");
	printf("%.3s", varfile->ext);
	}
	if (isdir == 1) {
		printf("]");
	}
	if (isdir == 0) {
		printf ("    ");
		printf ("%u", varfile->size);
		printf (" bytes");
	}
	printf("\n");
}