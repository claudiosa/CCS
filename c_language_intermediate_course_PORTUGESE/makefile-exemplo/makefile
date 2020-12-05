
##############ORIGINAL DE http://www.arruda.blog.br/programacao/fazendo-um-makefile/
## USAR ::: make -f meu-make
CC=g++
CFLAGS=-c -Wall
LDFLAGS=
#SOURCES= fontes/main.cpp fontes/hello_world.h 
SOURCES= alo-mundo.c envia-num-rand.c pgm-principal.c conta_caract_frase.c  multp-10.c
#OBJECTS=$(SOURCES:.cpp=.o)
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE= testando-exe
all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.c.o:
	$(CC) $(CFLAGS) $< -o $@
	@echo "Fiz a compilação para CODIGO OBJETO"

### execute-a como make clean -f meu-make 
clean:
	rm -rf *.o
	@echo "apaguei os objetos"
#### MELHORAR ESTA PARTE FINAL...
