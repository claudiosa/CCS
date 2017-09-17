#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

#define MAX 3
 typedef struct stack
	{
	  int topo ;
	  char entradas[MAX];
	}  tipo_pilha;

void inicializa_pilha ( tipo_pilha * X);
void push (char x, tipo_pilha * P);
void pop (char *x, tipo_pilha * P);

 void main(void)
{
	char x;
	tipo_pilha  * P; /* criar por referencia
        para nao duplicar os dados do campo entrada.... */
	inicializa_pilha ( P );
printf("\n /************** empilhando ************/\n");
	do
	{
        printf("\n Digite caracter a Pilha::  ");
        fflush(stdin);
	x = (char)getchar();
	push ( x , P );
	}
       while ( x != '\n');
/* nao eh interessante usar P->topo como parada....
   pois o mesmo nao incrementa em caso de pilha
   cheia... logo ... seu valor maximo eh MAX-1
*/
printf("\n/************** desempilhando ************/\n");
	do
	{
        pop( &x , P);
        printf("\n Caracter do topo ::  ");
	putchar( x );
	}
	while ( P -> topo != 0 );
	pop( &x , P); /* testando e forcando o pilha vazia */
	printf("\n FIM:: P -> topo:: %d",  P -> topo);
}
/************************************************/