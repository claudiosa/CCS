#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#define MAX_FILA 5

typedef struct modelo_da_fila
	{
	  int  count ; 		 /* num_corrente  */
	  int  front ;  		/*  or first */
	  int  rear ;	  		/*  or last */
	  char entradas[ MAX_FILA ];
	}  fila ;

typedef int boolean;

int tamanho_fila ( fila * F );
boolean  fila_cheia  ( fila * F);
void inicializa_fila ( fila * X);

void carrega_fila (  fila * X );
void mostra_fila (  fila * X );

void chegada (char x, fila * F);
void partida (char *x, fila * F);

void main(void)
{
	char vetor[]= "XYZ";
	char y;
	int i,j;
	fila   Fila_fisica;
	fila  * X_fila; /* criar por referencia para nao duplicar os dados.... */
	X_fila = & Fila_fisica; /* senao for desse jeito... no LINUX ==> problema */

	inicializa_fila ( X_fila );
/*	carrega_fila ( X_fila ); */
	for ( i = 0 ; i <= 7 ; i ++ )
	{
			for ( j = 0 ; j < 3 ; j ++ ) /* chegam 3 */
			chegada ( vetor[j], X_fila );

			puts("====================================");
			mostra_fila ( X_fila );

			for ( j = 1 ; j <= 2 ; j ++ ) /* partem 2 */
			partida ( &y , X_fila );

			puts("====================================");
			mostra_fila ( X_fila );

	}
  } /* fim do main */

void carrega_fila (  fila * X )
{
	char vetor[]= "ZIstoxxxX";
	int i, tam_vetor =(int)sizeof(vetor);
	/*	se o tamanho da fila for maior que tam_vetor ....
		o '\0' serah tambem emfilado
	*/
	printf("\n QTIDADE DE OBJETOS:::%d", tam_vetor );
	for(i=0; i < tam_vetor ; i++)
	{
	 chegada ( vetor[i], X );
	 if ( fila_cheia (X ) )
	 break;
	}
	return;
}

/************************************************/
void mostra_fila (  fila * F )
{ /* sem mexer no conteudo real */
  int aux, i ;
  aux = (F -> front);
  i = 1; /* primeiro da fila */
  while ( i <= (F -> count))
  printf (" %do..::" , i++);
  printf("\n");
  while ( aux != (F -> rear) )
  {
	printf(" [%d]:%c " , aux , F -> entradas [ aux ] );
	aux = ( aux + 1 ) % MAX_FILA ;
  }
  printf("[%d]:%c " , aux, F -> entradas [ aux ] );
  getchar();
  return;
}
/************************************************/