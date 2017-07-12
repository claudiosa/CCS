#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

  typedef struct node
	{
	  int idade ;
	  struct node *next;
	} no_modelo;

typedef no_modelo  noh_id;

noh_id * ins_ord(int x, noh_id * L);
void imp_lista1(noh_id *L);
noh_id * cria_no(void);

 void main(void)
{
	int vetor[]= { 2,5,-17,110,99,54,1,2,-9};
	int i;
	noh_id  *L; /* APENAS NA PILHA ... NOH ESTATICO*/
	L = NULL;
	int max =(int)sizeof(vetor)/sizeof(int);

	for(i=0; i < max ; i++)
	{ L = ins_ord( vetor[i], L );
	}
	imp_lista1( L );
}


noh_id *  ins_ord(int x, noh_id * L)
{
	noh_id * no_ant, * novo, * aux;
	novo = cria_no();

	novo -> idade = x; /* atribui valor */
	aux = no_ant = L; /* aux == noh_id_corrente */

 if(aux == NULL) /* no caso de nada na HEAP */
 {	novo -> next =  NULL;
	L = novo;
	return (L);
 }

while((x > (aux -> idade)) && no_ant -> next != NULL)
/* enquanto o noh_id corrente for menor que o valor a ser inserido...
	entao vah adiante....*/
  { no_ant = aux;
	 aux = aux -> next;
  }
/* CASO TENHA APENAS UM NOH NA LISTA JAH INSERIDO */
	if (no_ant == aux ) /* nao entrou no loop ... havia 1 soh noh */
	{
	 if ((x > (aux -> idade)))
	 {
		aux -> next = novo;
		novo -> next =  NULL ; /* caso nao inicializado no cria_no */
		return (aux);
	  }
	  else
	  {
		novo -> next =  aux ;
		return (novo);
	  }
	 }
	/* TROCA NORMAL PADRAO */
	novo -> next = aux ;
	no_ant -> next = novo ;
	return (L) ;
}

void imp_lista1(noh_id *L)
{
	int i = 1;
	if (L == NULL )
	{ printf("\n LISTA VAZIA !");
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

