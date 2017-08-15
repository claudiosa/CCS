#include <stdio.h>
#define MAX 30


typedef struct stack
	{
	  int topo ;
	  char entradas[MAX];
	}  tipo_pilha;
/*
enum valores_logicos {FALSE=0, TRUE=1};
typedef struct
	{valores_logicos;}
	 boolean;
*/
int pilha_cheia  (tipo_pilha * P);
int pilha_vazia  (tipo_pilha * P);

void push (char x, tipo_pilha * P)
{
   if ( pilha_cheia ( P ))
   /* voltando 1 ou true se estiver estah cheia */
   { printf("\n A PILHA ESTAH CHEIA ");
     getchar();
     return;
    }
       /* ou seja ... entrada[1] vai ter o 1o. elemento
          empilhado... estamos perdendo entrada[0]... */
    ++ (P -> topo);
    P -> entradas[ P -> topo ] = x;
    printf("\nPUSH:: %c, TOPO:: %d", P->entradas[P->topo ],P->topo);
    return;
  } /* fim da funcao push */


void pop (char * x, tipo_pilha * P)
{
   if ( pilha_vazia ( P ))
   /* voltando 1 ou true se estiver estah vazia */
   { printf("\n A PILHA ESTAH VAZIA ");
     getchar();
     return;
	}

	 * x = P -> entradas[ P -> topo ];
	 printf("\nPOP:: %c, TOPO:: %d", P->entradas[P->topo ],P->topo);
	 -- (P -> topo);
	 return;
  } /* fim da funcao pop */


int pilha_cheia  (tipo_pilha * P)
{ /* estarah cheia se o topo for maior que o maximo - 1 permitido...
     entao retorna TRUE ou 1
  */
 return( P -> topo >= MAX-1 );
 /* FALSE ==> 0
    TRUE ===> 1
 */
}
int pilha_vazia  (tipo_pilha * P)
{ /* estarah vazia se o topo for menor que 0...
     entao retorna TRUE ou 1
  */
 return( P -> topo <=  0 );
 /* FALSE ==> 0
    TRUE ===> 1
 */
}

void inicializa_pilha ( tipo_pilha * X)
{ X -> topo = 0 ; }
