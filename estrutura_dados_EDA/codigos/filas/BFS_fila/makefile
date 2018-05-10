all: bfs.exe

bfs.exe: fila_INT.o bfs_fila.o
	gcc -Wall -o bfs.exe fila_INT.o bfs_fila.o

fila_INT.o: fila_INT.c
	gcc -Wall -c fila_INT.c

bfs_fila.o: bfs_fila.c
	gcc -Wall -c bfs_fila.c

clean:
	rm *.o *.exe *.out

run: ./bfs.exe   ### para o run.codes
