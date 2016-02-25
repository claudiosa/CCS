#include <stdio.h>
#define MAX_FILA 5


typedef struct modelo_da_fila
	{
	  int  count ; 		 /* num_corrente  */
	  int  front ;  		/*  or first */
	  int  rear ;	  		/*  or last */
	  char entradas[ MAX_FILA ];
	}  fila ;

	typedef int boolean;
	boolean  fila_cheia  ( fila * F);
	boolean  fila_vazia  ( fila * F);
	int tamanho_fila ( fila * F );

void chegada ( char x, fila * F )
{
	if ( fila_cheia ( F ))
	/* voltando 1 ou true se estiver estah cheia */
	{ printf("\n A FILA ESTAH CHEIA ");
	  getchar();
	  return;
		}
  /* incrementa fila adiciona mais um no final... */
	 ++ (F -> count );
	 F -> rear =  ((F -> rear) + 1) % MAX_FILA ;
	 F -> entradas [ F -> rear ] = x;
/*	 printf("\nFRONT: %c || REAR: %c", F->entradas[F->front],F->entradas[F->rear]);
*/
	 return;
  } /* fim da funcao de chegada */


void partida (char * x, fila * F)
{
	if ( fila_vazia ( F ))
	/* voltando 1 ou true se estiver estah vazia */
	{ printf("\n A FILA ESTAH VAZIA ");
	  getchar();
	  return;
	}
	 -- (F -> count );  					/* == F -> count --; */
	 * x = F -> entradas[ F -> front ];
/*	 printf("\nFRONT: %c || REAR: %c", F->entradas[F->front],F->entradas[F->rear]);
*/
	 /* atualiza novo noh-cabeca ou o proximo da fila */
	 F -> front =  ((F -> front) + 1) % MAX_FILA ;

	 /* IMPLEMENTANDO-SE COM UM ARRAY CIRCULAR...
		 onde o indice vai rotacionar no sentido anti-horario...
		 temos um limite MAX de MAX_FILA - 1... ou seja:
		 if ( i > = MAX_FILA - 1 )
		 i= 0;
		 else
		 i++;
		 logo ... a sequencia acima eh equivalente a operacao ::
		 i = (i+1) % MAX_FILA ;
	 */
	 return;
  } /* fim da funcao servico */


boolean fila_cheia  ( fila * F )
{ /* estarah cheia se o count for >= ao maximo permitido...
	  entao retorna TRUE ou 1  */
 return(( F -> count) >= MAX_FILA );
 /* FALSE ==> 0
	 TRUE ===> 1		 */
}
boolean fila_vazia  ( fila * F )
{ /* estarah vazia se o  for menor que 0...
	  entao retorna TRUE ou 1 */
 return( F -> count <=  0 );
 /* FALSE ==> 0
	 TRUE ===> 1 */
}

void inicializa_fila ( fila * X)
{ 	X -> count = 0 ;
	X -> front = 0 ;
	X -> rear = -1 ;
	return;
}

int tamanho_fila ( fila * F )
 {
	return ( F -> count );
 }
