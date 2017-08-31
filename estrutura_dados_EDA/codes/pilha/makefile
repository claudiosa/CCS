all: saida.exe

saida.exe: pilha00_A.o pilha01_A.o
	g++ -o saida.exe pilha00_A.o pilha01_A.o

pilha00.o: pilha00_A.cpp
	g++ -c pilha00_A.cpp


pilha01.o: pilha01_A.cpp
	g++ -c pilha01_A.cpp

clean:
	rm pilha00_A.o pilha01_A.o saida.exe
