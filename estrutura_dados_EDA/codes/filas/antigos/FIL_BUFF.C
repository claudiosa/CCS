/*Fila sob demanda ... c/ limite MAXIMO TAM_BUFFER; */
#include<stdio.h>
#define MAX_VETOR 10
#define TAM_BUFFER 3

typedef struct
		  {
			int tam;
			int rear;
			int front;
			char entradas[MAX_VETOR];
		  }fila;

void mostra_fila (  fila * F );
void chegada (char x,fila *f);
void partida (char *y,fila *f);
void inicializa_fila ( fila * X );
int fila_vazia (fila * X);
int fila_cheia (fila * X );

void main()
{
	fila *f, Fila_fisica;
	char vetor1[7] = {'A','B','C','D','E','F','G'} ;
	int i , j;
	f = &Fila_fisica;

	inicializa_fila ( f ); /* nao esquecer */
	printf("\n======================= INICIO ===========================\n");

	/*	carrega_fila ( X_fila ); */
	for ( i = 0 ; i <= 3 ; i ++ )
	{
			for ( j = 0 ; j < 7 ; j ++ ) /* chegam 3 */
			chegada ( vetor1[j], f );

			printf("\n===========================================================\n");
			mostra_fila ( f );
	 }
  }
/*******************************/
void chegada (char x, fila *f)
{
 char aux;
 if (fila_cheia(f)) /* ou if (f->tam >= TAM_BUFFER)*/
	  {partida ( &aux ,f);
		printf("\n Buffer estava cheio => ocorreu uma partida de:: %c ", aux);
	  }
	/* apos a partida... ha uma nova entrada */
	printf("\n O lugar vago no Buffer foi ocupado por:: %c ", x );
	f-> tam = ( ( f -> tam) + 1 );
	f-> rear  =( ( f->rear) + 1 ) % MAX_VETOR;
	f-> entradas [f->rear] = x ;
	return;
}

void partida (char *x, fila *f)
{
 if (fila_vazia(f))
	{
	 printf("\n A fila esta vazia");
	 return;
	}
	 f -> tam = (( f -> tam) - 1 );
	 *x = f -> entradas[ f -> front ] ;
	 f -> front = ( ( f -> front ) + 1) % MAX_VETOR ;
	 return;
}

int fila_cheia (fila *f)
{  /* uma das diferencas estah aqui.... */
	return ( (f -> tam) >= TAM_BUFFER );
}

int fila_vazia (fila *f)
{	return ( (f->tam) == 0 ); }

void inicializa_fila ( fila * X)
{ 	X -> tam = 0 ;
	X -> front = 0 ;
	X -> rear = -1 ;
	return;
}
/************************************************/
void mostra_fila (  fila * F )
{ /* sem mexer no tameudo real */
  int aux, i ;
  aux = (F -> front);
  i = 1; /* um mostrador ... indice qualquer */
  while ( i <=  (F -> tam) ) /* imprime algo se 1 <= 1 ...
  ou seja... pelo menos um na fila .....*/
  printf( " %do..::" , i++);

  if( (F -> tam) > 0 ) /* soh se fila diferente de 0 */
  {
	printf( "\n");
	while ( aux != (F -> rear) )
	{
		printf(" [[%d]:%c] ", aux , F -> entradas[aux]);
		aux = ( aux + 1 ) % MAX_VETOR ;
	}
	printf(" [[%d]:%c] ", aux , F -> entradas[aux]);
	}
	return;
}
/*************************************************/
