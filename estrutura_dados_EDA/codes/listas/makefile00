all: relocavel.exe

relocavel.exe: lista_00.o usa_lista_00.o
	gcc -Wall -o relocavel.exe lista_00.o usa_lista_00.o

lista_00.o: lista_00.c
	gcc -Wall -c lista_00.c

usa_lista_00.o: usa_lista_00.c
	gcc -Wall -c usa_lista_00.c

clean:
	rm *.o *.exe 