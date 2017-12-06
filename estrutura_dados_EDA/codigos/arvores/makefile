all: relocavel.exe

relocavel.exe: arv_bin.o usa_arv_bin_01.o exclui_no_ABB.o
	gcc -Wall  -o relocavel.exe arv_bin.o usa_arv_bin_01.o exclui_no_ABB.o

arv_bin.o: arv_bin.c
	gcc -Wall  -c arv_bin.c

usa_arv_bin_01.o: usa_arv_bin_01.c
	gcc -Wall  -c usa_arv_bin_01.c

exclui_no_ABB.o: exclui_no_ABB.c
	gcc -Wall -c exclui_no_ABB.c
	
clean:
	rm *.o *.exe a.out
