
all: relocavel.exe

relocavel.exe: f1.o f2.o f3.o f4.o meu_main.o 
	gcc -Wall  -o relocavel.exe f1.o f2.o f3.o f4.o meu_main.o

f1.o: f1.c
	gcc -Wall -c f1.c

f2.o: f2.c
	gcc -Wall -c f2.c

f3.o: f3.c
	gcc -Wall -c f3.c

f4.o: f4.c
	gcc -Wall -c f4.c

meu_main.o: meu_main.c
	gcc -Wall -c meu_main.c

clean:
	rm *.o *.exe
