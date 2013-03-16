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

char* createname (struct file* varfile){
	char *temp;
	int j = 0;
	int i;
	for (i= 0; i<8; i++){
		if (varfile->name[i] != ' '){
			temp [j] = varfile->name[i];
			j++;
		}
		
	}
	temp [j] = '.';
	j++;
	for (i=0; i<3; i++){
		temp [j] = varfile->ext[i];
		j++;
	}
	temp[j] = 0;
	return temp;
}