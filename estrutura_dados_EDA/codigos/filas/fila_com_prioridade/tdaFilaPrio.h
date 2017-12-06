#ifndef FILA_PRIO_H
#define FILA_PRIO_H

/* no turboC para DOS use:
 #include "client~1.h"*/

#define LIVRE 0
#define OCUPADA 1
#define FRACASSO 0
#define SUCESSO 1
#define FALSO 0
#define VERDADEIRO 1
#define NAO 0
#define SIM 1
#define MAIOR 1
#define IGUAL 0
#define MENOR -1

typedef struct fila Fila;

int cria(Fila **pp, int tamInfo);
int insere(Fila *p, void * novo,int (* cmp)(void *x, void *y) );
int buscaNaFrente(Fila *p, void *pReg);
int buscaNaCauda(Fila *p, void *pReg);
int retira(Fila *p, void *pReg);
void destroi(Fila **pp);
int purga(Fila *p);
int testaVazia(Fila *p);
void vaivem(Fila *p, void (* func)(void *x) );

#endif
