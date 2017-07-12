#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

  typedef struct node
	{
	  int idade ;
	  struct node *next;
	} no_modelo;

typedef no_modelo  noh_id;

noh_id * ins_inic (int x, noh_id * L);
noh_id * remover (int x, noh_id * L);
void imp_lista1(noh_id *L);
noh_id * cria_no(void);

void  main(void)
{
  //	int vetor[]= { 2,2,5,-17,2,110,2,99,2,2,54,1,2,-9,2, 2};
	int vetor[]= { 2,2,2,2,2,2 };

	int i;
       	int max;
	noh_id  *L; /* APENAS NA PILHA ... NOH ESTATICO*/
	L = NULL;
        max = (int)sizeof(vetor)/sizeof( i );

	for(i=0; i < max ; i++)
	{ L = ins_inic( vetor[i], L );
	}
	imp_lista1( L );
	L = remover ( 2, L );
	printf("\n\n Lista removida \n\n ");
	imp_lista1( L );
}

noh_id * remover (int x, noh_id * L)
{
	noh_id * aux, * corrente, *anterior;

 if( L == NULL) /* no caso de nada na HEAP */
 {
	printf("\n Lista vazia ... nao hah o que removerr ");
	getchar();
	return (L);
 }
	corrente = anterior = L;

	if ( corrente -> next == NULL )
	/* soh tem um noh na lista */
	{ if (corrente -> idade == x)
	  { free ( L );
		 L = NULL;
		 return ( L );
		}
	 }

while  (anterior -> next != NULL) /* tendo 1 noh nao entra aqui */
	{
	 if (corrente -> idade == x)
	 {
		if ( L != corrente )
		/* verifica se o noh corrente nao
			eh o 1o. noh a ser removido ===> caso tipico */
		{
		  anterior -> next = corrente -> next;
		  aux = corrente ;
		  corrente = corrente -> next;
		  free (aux);
		 }
		 else /* o 1o. noh coincide com a exclusao */
		 {
		  anterior = corrente -> next;
		  aux = corrente ;
		  corrente = corrente -> next -> next ;
		  /* avanca 2 nosh a frente ou  = anterior -> next*/
		  free (aux);
		  L = anterior; /* novo inicio de lista */
		 }
	  }
		else /* avanca normal */
		{
		anterior = corrente;
		corrente = corrente -> next;
		}
	} /* fim do wilhe */

 /* caso muito especial.... uma lista soh com x  ...
	 tira o ultimo  que restou  do while   */
	if ( L -> idade == x)
	  { free ( L );
		 L = NULL;
	  }

	return ( L );
}

noh_id *  ins_inic(int x, noh_id * L)
{
	noh_id  * novo;
	novo = cria_no();

	novo -> idade = x; /* atribui valor */

 if( L == NULL) /* no caso de nada na HEAP */
 {
	novo -> next =  NULL;
	L = novo;
	return (L);
 }
 /* INSERE NO INICIO ==> SEMPRE */
	novo -> next = L ;
	return (novo) ;
}

void imp_lista1(noh_id *L)
{
	int i = 1;
	if (L == NULL )
	{ printf("\n A LISTA ESTAH VAZIA !");
	 return; }

	for( ; (L -> next != NULL); L = L -> next)
	{printf("\n%do. Noh:::  Idade: %d", i, L -> idade);
	 i++;	}
	 printf("\n%do. Noh:::  Idade: %d", i, L -> idade);
	return;
}

noh_id * cria_no(void)
{
 noh_id  *new_no;
 if((new_no=(noh_id *)malloc(sizeof(noh_id))) == NULL)
	{
		printf("\n Erro de alocacao .... ");
		getchar();
		exit(1);
	}
	return(new_no);
 }

