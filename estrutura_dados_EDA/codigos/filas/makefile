all: saida.exe

saida.exe: fila_00.o usa_fila_01.o
	gcc -Wall -o saida.exe fila_00.o usa_fila_01.o

fila_00.o: fila_00.c
	gcc -Wall -c fila_00.c

usa_fila_01.o: usa_fila_01.c
	gcc -Wall -c usa_fila_01.c

clean:
	rm *.o *.exe *.out
