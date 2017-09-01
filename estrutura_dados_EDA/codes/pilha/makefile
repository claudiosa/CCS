all: saida.exe

saida.exe: pilha03_malloc.o pilha04_malloc.o
	gcc -Wall -o saida.exe pilha03_malloc.o pilha04_malloc.o


pilha03_malloc.o: pilha03_malloc.c
	gcc -Wall -c pilha03_malloc.c


pilha04_malloc.o: pilha04_malloc.c
	gcc -Wall -c pilha04_malloc.c

clean:
	rm pilha04_malloc.o pilha03_malloc.o saida.exe
