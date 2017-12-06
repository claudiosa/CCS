#include <stdio.h>
#define MAX_FILA 3

typedef struct modelo_da_fila
	{
	  int  count ; 		 /* num_corrente  */
	  int  front ;  		/*  or first */
	  int  rear ;	  		/*  or last */
	  char entradas[ MAX_FILA ];
	}  fila ;

	typedef int boolean;
	boolean  fila_cheia  ( fila * F );
	boolean  fila_vazia  ( fila * F );
	int tamanho_fila ( fila * F );

	void inicializa_fila ( fila * X );
	void chegada (char x, fila * F );
	void servico (char *x, fila * F );

 void main(void)
{
	char x;
	fila   Fila_fisica;
	fila  * F ; /* criar por referencia para nao duplicar os dados.... */
	F = & Fila_fisica; /* senao for desse jeito... no LINUX ==> problema */


	inicializa_fila ( F );
printf("\n /************** emfilando ************/\n");
	do
	{
		  printf("\n Chegando caracter na fila::  ");
		  fflush(stdin);
		  x = (char)getchar();
		  chegada ( x , F );
	}
		 while ( x != '\n');
/* nao eh interessante usar P->topo como parada....
	pois o mesmo nao incrementa em caso de fila
	cheia... logo ... seu valor maximo eh MAX-1
*/
printf("\n/************** desemfilando ************/\n");
	do
	{
		  servico( &x , F );
		  printf("\n Caracter de servico ::  ");
		  putchar( x );
	}
	while ( tamanho_fila ( F ) );
	servico( &x , F );	 /* testando e forcando o fila vazia */
	printf("\n FIM:: P -> front:: %c",  F -> front);
}
/************************************************/