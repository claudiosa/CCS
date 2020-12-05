#ifndef CLIENTE_H
#define CLIENTE_H

#ifdef  __unix__
   #define clrscr() printf("[2J")
#else
   #define clrscr() system("cls")
#endif

#define N 30
#define chave RG

#include "tdaFilaPrio.h"

typedef int tipoChave;

typedef struct {  
    char matricula[N];
    tipoChave chave;
} info;

void menu(Fila *p);
/*int compara(info *a, info *b);
*/
int compara(void *a, void *b);
void pause_();
void exibe(void *a);

#endif
