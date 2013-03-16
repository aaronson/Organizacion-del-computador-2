all: distort

distort: distort.c rubber.c texture.c update_states.o rubber_dynamics.o
	gcc -g distort.c rubber.c texture.c update_states.o rubber_dynamics.o -o distort -lGL -lGLU -lglut -lpthread

update_states.o: update_states.asm
	nasm -g -felf update_states.asm -o update_states.o

rubber_dynamics.o: rubber_dynamics.asm
	nasm -g -felf rubber_dynamics.asm -o rubber_dynamics.o

clean: 
	rm -f distort update_states.o rubber_dynamics.o
