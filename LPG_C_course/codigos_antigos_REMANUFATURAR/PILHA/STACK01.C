#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

#define MAX 30
 typedef struct stack
	{
	  int topo ;
	  char entradas[MAX];
	}  tipo_pilha;

void inicializa_pilha ( tipo_pilha * X);
void carrega_pilha (  tipo_pilha * X );
void mostra_pilha (  tipo_pilha * X );
void push (char x, tipo_pilha * P);
void pop (char *x, tipo_pilha * P);
 void main(void)
{
  
	tipo_pilha  *pilha; /* criar por referencia
        para nao duplicar os dados.... */
	inicializa_pilha ( pilha );
	carrega_pilha ( pilha );
        mostra_pilha ( pilha );

  } /* fim do main */

void carrega_pilha (  tipo_pilha * X )
{
	char vetor[]= "ZIstoX";
	int i, tam_vetor =(int)sizeof(vetor);
	/* 
	   se o tamanho da pilha for maior que tam_vetor ....
	   o '\0' serah tambem empilhado
        */
	printf("\n QTIDADE DE OBJETOS:::%d", tam_vetor );
	for(i=0; i < tam_vetor ; i++)
	push ( vetor[i], X );
	return;
}

void mostra_pilha (  tipo_pilha * X )
{
  char x; /* ou char *pt */
  printf("\n   mostra_pilha \n");
   while ( X -> topo != 0 )
    {
     pop ( &x , X );
     printf("\n Pilha[%d] :: %c", X -> topo, x);
    }
  return;
}
/************************************************/