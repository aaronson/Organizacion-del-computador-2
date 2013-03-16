all: shadow

shadow: shadow.c glm.c gltx.c trackball.c shadowmatrix.o normalize.o cross.o samplelights.o
	gcc -g shadow.c glm.c gltx.c trackball.c shadowmatrix.o cross.o samplelights.o normalize.o -o shadow -lGL -lGLU -lglut -lpthread
	
shadowmatrix.o: shadowmatrix.asm
	nasm -felf -g shadowmatrix.asm -o shadowmatrix.o
	
normalize.o: normalize.asm
	nasm -felf -g normalize.asm -o normalize.o
	
cross.o: cross.asm
	nasm -felf -g cross.asm -o cross.o
	
samplelights.o: samplelights.asm
	nasm -felf -g samplelights.asm -o samplelights.o
	
clean:
	rm -f shadow shadowmatrix.o normalize.o cross.o samplelights.o
