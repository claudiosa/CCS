/* Fila circular com realimentacao */
#include<stdio.h>
/*
	#include<conio.h>
	#include<string.h>
	#include<stdlib.h>
*/
#define MAX_FILA 10

typedef struct
		  {
			int tam;
			int front;
			int rear;
			int ciclos [MAX_FILA];
			char entradas[MAX_FILA];
		  } fila;

void mostra_fila (  fila * F );
void chegada (char  x, int ciclo, fila *X );
void partida (char *x, fila * X );
void inicializa_fila ( fila * X );
int fila_vazia (fila * X);
int fila_cheia (fila * X );


void main()
{
  fila *f, Fila_fisica;
  int i , j;
  char x;
  char vetor1[3] = { 'A' ,'B' ,'C'} ;
  int  vetor2[3] = { 3,    2,    1} ;

  f = &Fila_fisica;

  inicializa_fila ( f ); /* nao esquecer */

  /*	carrega_fila ( X_fila ); */
	for ( i = 0 ; i <= 7 ; i ++ )
	{
			for ( j = 0 ; j < 3 ; j ++ ) /* chegam 3 */
			chegada ( vetor1[j], vetor2[j], f );

			printf("\n====================================\n");
			mostra_fila ( f );

			for ( j = 1 ; j <= 3 ; j ++ ) /* algumas partidas */
			partida ( & x , f );

			printf("\n====================================\n");
			mostra_fila ( f );

	}
 } /* fim do main */
/************************************************/
void mostra_fila (  fila * F )
{ /* sem mexer no tameudo real */
  int aux, i ;
  aux = (F -> front);
  i = 1; /* contador ... indice qualquer */
  while ( i <=  (F -> tam) ) /* imprime algo se 1 <= 1 ...
  ou seja... pelo menos um na fila .....*/
  printf( " %do..::" , i++);

  if( (F -> tam) > 0 )
  {
	printf( "\n");
	while ( aux != (F -> rear) )
	{
		printf( " [[%d]:%c|%d] ", aux , F -> entradas[aux], F -> ciclos [aux]);
		aux = ( aux + 1 ) % MAX_FILA ;
	}
	printf( " [[%d]:%c|%d] ", aux , F -> entradas[aux], F -> ciclos [aux]);
	}
	return;
}

void chegada (char x, int quantum, fila *f)
/* chegam valores de x e ciclo */
{
 if (fila_cheia(f))
	{
	 printf("\n A fila esta Cheia");
	 return;
	}

	 f-> tam  =((f->tam) + 1);
	 f-> rear  =( ( f->rear) + 1) % MAX_FILA;
	 f-> ciclos  [ f -> rear ] = quantum;
	 f-> entradas[ f -> rear ] = x ;
	 return;
}

void partida (char *x, fila *f )
{
 int loop;
 if (fila_vazia(f))
	{
	 printf("\n A fila esta Vazia");
	 return;
	}
  /* partida se verifica se o job jah atingiu seu objetivo */
	 if ( (f -> ciclos [f->front]) == 0)
	 { /* partida para sempre ==> convencional */
		 f -> tam = (( f -> tam) - 1 );
		 *x = f -> entradas[ f -> front] ;
		 f -> front = ( ( f -> front ) + 1) % MAX_FILA ;
		 printf("\n Job com partida definitiva !: %c ", *x);
		 return;
	 }
	 else
	 /* realimenta no final da fila */
	 {
		if (fila_cheia(f))
		{
			printf("\n A fila esta Cheia ===> SEM REALIMENTACAO....");
			return;
		}
		  /* "decrementa" no inicio da fila ==> avanca indice */
		 *x = f -> entradas [ f -> front ];
		 loop =  f -> ciclos [ f -> front ];
		 f -> front = ( ( f -> front ) + 1) % MAX_FILA;
		 printf("\n Job realimentando a fila|falta :: [%c|%d] ", *x, loop-1 );

	  /* incrementa fila,  mas, adiciona no final... realimenta OK*/
		 f -> rear = ( (f -> rear) + 1) % MAX_FILA ;
		 f -> entradas [ f -> rear ] = *x;
		 /* decrementa o tamador de voltas */
		 f -> ciclos [f -> rear ] = loop - 1;
		 /* observar que o tamanho da fila econtra-se inalterado aqui */
		 return;
	 }
 }
 /*****************************************************/
int fila_cheia (fila *f)
{
	return ( (f -> tam)  >= MAX_FILA );
}

int fila_vazia (fila *f)
{
	return ( (f->tam) == 0 );
}

void inicializa_fila ( fila * X)
{ 	X -> tam = 0 ;
	X -> front = 0 ;
	X -> rear = -1 ;
	return;
}

