all: main.exe

saida.exe: pilha_malloc.o usa_pilha_malloc.o
	gcc -Wall -o saida.exe pilha_malloc.o usa_pilha_malloc.o

pilha_malloc.o: pilha_malloc.c
	gcc -Wall -c pilha_malloc.c

usa_pilha_malloc.o: usa_pilha_malloc.c
	gcc -Wall -c usa_pilha_malloc.c

clean:
	rm usa_pilha_malloc.o pilha_malloc.o saida.exe

run: 
	./saida.exe
