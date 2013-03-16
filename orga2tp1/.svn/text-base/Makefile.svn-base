all: main

main: main.c statsize.c printsize.c printboot.c createname.c imprimir.o lsdir.o redopath.o removeslash.o comparestring.o redostring.o printdir.c sizedir.o calcsize.o extraer.o 
	gcc -g main.c statsize.c printsize.c printboot.c printdir.c createname.c lsdir.o imprimir.o removeslash.o redostring.o comparestring.o sizedir.o calcsize.o extraer.o redopath.o -o main


lsdir.o: lsdir.asm
	nasm -felf -g lsdir.asm -o lsdir.o

imprimir.o: imprimir.asm
	nasm -felf -g imprimir.asm -o imprimir.o

comparestring.o: comparestring.asm
	nasm -felf -g comparestring.asm -o comparestring.o

sizedir.o: sizedir.asm
	nasm -felf -g sizedir.asm -o sizedir.o
	
redopath.o:
	nasm -felf -g redopath.asm -o redopath.o

calcsize.o: calcsize.asm
	nasm -felf -g calcsize.asm -o calcsize.o

extraer.o: extraer.asm
	nasm -felf -g extraer.asm -o extraer.o
	
redostring.o: redostring.asm
	nasm -felf -g redostring.asm -o redostring.o

removeslash.o:
	nasm -felf -g removeslash.asm -o removeslash.o

clean:
	rm -f imprimir.o main lsdir.o comparestring.o sizedir.o calcsize.o extraer.o
	

 
