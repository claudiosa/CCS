all: saida.exe

saida.exe: pilha05_realloc.o pilha06_realloc.o
	gcc -Wall -o saida.exe pilha05_realloc.o pilha06_realloc.o


pilha05_realloc.o: pilha05_realloc.c
	gcc -Wall -c pilha05_realloc.c

pilha06_realloc.o: pilha06_realloc.c
	gcc -Wall -c pilha06_realloc.c

clean:
	rm pilha05_realloc.o pilha06_realloc.o saida.exe
