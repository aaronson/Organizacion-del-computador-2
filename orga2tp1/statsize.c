#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>



// int main(int argc, char* argv[])
// {
// 
// 	int x = sizeof(struct stat);
// 	printf ("%d \n",x);
// 	return 0;
// }

int statsize (){
	int x = sizeof(struct stat);
	return x;
}