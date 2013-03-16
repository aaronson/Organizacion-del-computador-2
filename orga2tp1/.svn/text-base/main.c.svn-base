#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

extern void imprimir (char* imagen);
extern void lsdir (char* directorio, char* imagen);
extern int comparestring (char* longstr, char* shortstr);
extern void sizedir (char* directorio, char* imagen);
extern void extraer (char* archivo, char* imagen);

int main(int argc, char* argv[]){
	 if (argc > 1) {
		 if (*(argv[1]+1) == 'v'){
			 imprimir (argv[2]);
		 }else if (*(argv[1]+1) == 'l'){
			 lsdir (argv[2], argv[3]);
		 }else if (*(argv[1]+1) == 's'){
			 sizedir (argv[2], argv[3]);
		 }else if (*(argv[1]+1) == 'e'){
			 extraer (argv[2], argv[3]);
		 }else{
			  printf("%s\n", "Por favor utilice los parámetros requeridos por la función. Use ./main -v IMAGEN para ver su información; use ./main -l DIRECTORIO IMAGEN para obtener un dir del directorio; use ./main -s DIRECTORIO IMAGEN para obtener el tamaño de un directorio; use ./main -e ARCHIVO IMAGEN para extraer un archivo de la imagen");
		 }
	 }else{
		 printf("%s\n", "Por favor utilice los parámetros requeridos por la función. Use ./main -v IMAGEN para ver su información; use ./main -l DIRECTORIO IMAGEN para obtener un dir del directorio; use ./main -s DIRECTORIO IMAGEN para obtener el tamaño de un directorio; use ./main -e ARCHIVO IMAGEN para extraer un archivo de la imagen");
	 }
	 

		
	//imprimir ("image1.bin");
	//lsdir("/DIR2/SUBDIRD/SS2/SSS2/SSSS1/", "image1.bin");
	//sizedir("/DIR1/", "TEST1.bin");
	//int n = comparestring("DIR2/","DIR2       ");
	//printf ("%u\n",n);
	//extraer ("/DIR1/YYYTTT.DXG/","TEST1.bin");
	return 0;
}
