
all: relocavel.exe

relocavel.exe: lista_LSE.o usa_lista_LSE.o
	gcc -Wall -o relocavel.exe lista_LSE.o usa_lista_LSE.o

lista_LSE.o: lista_LSE.c
	gcc -Wall -c lista_LSE.c

usa_lista_LSE.o: usa_lista_LSE.c
	gcc -Wall -c usa_lista_LSE.c

clean:
	rm *.o *.exe
