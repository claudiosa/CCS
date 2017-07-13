#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
/* ultima atualizacao ....15/09/98 */
 
  typedef struct node
	{
	  int idade ;
	  struct node *next;
	  struct node *prior;
	} no_modelo;

typedef no_modelo  dupla;


dupla * cria_no(void)
{
 dupla  *new_no;

 if((new_no=(dupla *)malloc(sizeof(dupla))) == NULL)
	{
		printf("\n Erro de alocacao .... ");
		getchar();
		exit(1);
	}
   
 new_no -> next = NULL;
 new_no -> prior = NULL;

	return(new_no);
 }

dupla * cria_lista(void)
{
	dupla *L;
	L = cria_no ();  /* criando a lista na HEAP */
	L -> next = NULL; /* aterrando */
	return (L);
}
/* para duplamente encadeada ... com
	nos extremos aterrados
*/
void  destroi_list_1 (dupla * *L )
 {
  int i=0;
  dupla * AUX = *L;
  if (*L == NULL)
  {
	 printf("\n A LISTA ESTAVA VAZIA !");
	 return;
	}

	while ( (*L) -> next != NULL )
		{
			AUX = *L;  /* a ordem interessa */
			(*L) = (*L) -> next;
			free( AUX );
			i++;
		}

	free ( *L );
   *L = NULL;
	printf("\n Foram liberados %d nos !", i+1);
	return;
	}

/* para duplamente encadeada ... com
	nos extremos ligados ===> inicio --- fim
*/
void  destroi_list_2 (dupla * *L )
 {
  int i=0;
  dupla * ANC, *AUX ;
  AUX = *L;
  ANC = (*L) -> prior; /* ultimo noh da lista ordenada */
  if (*L == NULL)
  {
	 printf("\n A LISTA ESTAVA VAZIA !");
	 return;
  }
 while ( (*L) != ANC )
	{
		AUX = *L;   /* NAO PODE TROCAR ESSA ORDEM */
		(*L) = (*L) -> next; /* TRAVAMENTO NA CERTA */
		free( AUX ); /* EH INSTANCIAR ALGUEM QUE JAH FOI DESALOCADO */
		i++;
	}
	/* para uma ultima vez */
	free ( ANC ); /* para o ultimo */
	*L = NULL ; /* garantindo aterramento NULL */
	printf("\n Foram liberados %d nos !", i+1);
	return;
	}

 void libera_no(dupla * X_no )
 {
  free ( X_no );
  return;
  }


/*imprime  para duplamente encadeada ... com
	nos extremos ATERRADOS ===> inicio --- fim
*/
void imp_lista_1(dupla *L)
{
	int i = 1;
	if (L == NULL )
	{
	 printf("\n LISTA VAZIA !");
	 return;
	 }

	for( ; (L -> next != NULL)&& i< 17; L = L -> next)
	{
	  printf("\n%do. Noh:::  IDADE: %d", i, L -> idade);
	  i++;
	}
	  printf("\n%do. Noh:::  IDADE: %d", i, L -> idade);
	return;
}

/* para duplamente encadeada ... com
	nos extremos ligados ===> inicio --- fim
*/
void imp_lista_2( dupla *L )
{
	int i = 1;
	dupla * ANC ;
	ANC = L;
	if (L == NULL )
	{
	 printf("\n LISTA VAZIA !");
	 return;
	 }
	/* em ANC estah o 1o. NOH */
	for( ; (L -> next != ANC )&& i < 17 ; L = L -> next)
	{
	  printf("\n%do. Noh:::  IDADE: %d", i, L -> idade);
	  i++;
	}
	  printf("\n%do. Noh:::  IDADE: %d", i, L -> idade);
	return;
}

int tamanho ( dupla *L )
{
	int i = 0;
	if (L == NULL ) /* inexistente */
	return(0);

	for( ; (L -> next != NULL); L = L -> next)
	i++;

	return(i+1); /* =1 devido ao ultimo noh */
}

