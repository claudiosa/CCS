all: relocavel.exe

relocavel.exe: arv_bin.o app_arv_bin.o exclui_no_arv_bin.o le_arq_arv_bin.o
	gcc -Wall  -o relocavel.exe arv_bin.o app_arv_bin.o exclui_no_arv_bin.o le_arq_arv_bin.o

arv_bin.o: arv_bin.c
	gcc -Wall  -c arv_bin.c

app_arv_bin_01.o: app_arv_bin.c
	gcc -Wall  -c app_arv_bin.c

exclui_no_ABB.o: exclui_no_arv_bin.c
	gcc -Wall -c exclui_no_arv_bin.c
	
le_arq_arv_bin.o: le_arq_arv_bin.c
	gcc -Wall -c le_arq_arv_bin.c
		
clean:
	rm *.o *.exe 
####a.out
