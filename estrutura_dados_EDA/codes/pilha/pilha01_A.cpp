#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>


#define MAX 50
typedef struct stack
	{
	   int topo ;
	   char entradas[MAX];
	}  tipo_pilha;

// FALTAM ALGUMAS FUNCOES SEMI-PRONTAS
void inicializa_pilha ( tipo_pilha * Pilha);
void carrega_pilha (  tipo_pilha * Pilha );
void imprime_pilha (  tipo_pilha * Pilha );
void push (char x, tipo_pilha * P);
void pop (char *x, tipo_pilha * P);

int main(void)
{
    tipo_pilha  PILHA; 
	tipo_pilha  *pt_pilha; /* criar por referencia 
	para nao duplicar os dados .... */
	pt_pilha = &PILHA; 
	inicializa_pilha ( pt_pilha );
	carrega_pilha ( pt_pilha );
    imprime_pilha ( pt_pilha );
    printf("\n PROFS are humans also .....\n");
   return 1;
  }

// UMA APLICACAO QUALQUER AQUI

// USO DO PUSH
void carrega_pilha (  tipo_pilha * P )
{
	char vetor[]= "QUALQUER COISA AQUI";
	int i, tam_vetor = (int)sizeof(vetor);
	printf("\n QTIDADE DE OBJETOS:::%d", tam_vetor );
	/*  se o tamanho da pilha for maior que tam_vetor ....
	   o '\0' serah tambem empilhado
    */
	
	for(i=0; i < tam_vetor ; i++)
	push ( vetor[i] ,  P );
	return;
}

// USO DO POP
void imprime_pilha ( tipo_pilha * P )
{ // usando pop
  char x; /* ou char *pt */
  printf("\n   mostra_pilha \n");
   while ( P -> topo >= 0 ) // cuidar onde a pilha se inicializa
    {
     pop ( &x , P );
     // printf("Pilha[%d]:%c ||", X -> topo, x);
     // printf("\n Pilha[%d] :: %c", X -> topo, x);
    }
  return;
}
/************************************************/
