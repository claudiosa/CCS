
all: relocavel.exe

relocavel.exe: arv_bin.o usa_arv_bin_01.o
	gcc -Wall -std=c99 -o relocavel.exe arv_bin.o usa_arv_bin_01.o

lista_LSE.o: arv_bin.c
	gcc -Wall -std=c99 -c arv_bin.c

usa_lista_LSE.o: usa_arv_bin_01.c
	gcc -Wall -std=c99  -c usa_arv_bin_01.c

clean:
	rm *.o *.exe
