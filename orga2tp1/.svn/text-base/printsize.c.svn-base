#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>

void printsize (int size){
	printf("%s", "El tamaño del directorio es ");
	printf("%d", size);
	if (size == 1){
	printf (" byte");
	}else{
	printf(" bytes");
	}
	printf("\n");
}