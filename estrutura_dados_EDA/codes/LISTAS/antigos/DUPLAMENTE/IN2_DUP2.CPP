#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

  typedef struct node
	{
	  int idade ;
	  struct node *next;
	  struct node *prior;
	} no_modelo;

typedef no_modelo  dupla;

 void ins_ord(int x, dupla * &L);
 void imp_lista_2(dupla *L);
 void destroi_list_2 (dupla * * L );
 dupla * cria_no( void);
 dupla * ache_nova_cabeca(dupla * L);

 void main(void)
{
	int vetor[]= { 2,5,-17,110,99,54,1,2,-9};
	int i;
	dupla  *L; /* APENAS NA PILHA ... NOH ESTATICO*/
	L = NULL;
	int max =(int)sizeof(vetor)/sizeof(int);

	for(i=0; i < max ; i++)
	{	ins_ord( vetor[i], L );
	}
	printf("\n passou aqui ....1");
	imp_lista_2( L );
	printf("\n passou aqui ....2");
	destroi_list_2( & L );
	imp_lista_2( L );
	printf("\n passou aqui ....3");
}

/* insercao ordenada com o inicio e fim da lista
	interligados ==> ultimo <--> primeiro */
void  ins_ord(int x, dupla * &L)
{
	dupla * no_ant, * novo, * aux;
	novo = cria_no();

	novo -> idade = x; /* atribui valor */

	aux = no_ant = L; /* aux == noh_corrente */

 if(aux == NULL) /* no caso de nada na HEAP */
 {
	novo -> next =  novo;
	novo -> prior = novo;
	L = novo;
	return;
  }

while((x > (aux -> idade))&& no_ant -> next != L)
/* enquanto o noh corrente for menor que o valor a ser inserido...
	entao vah adiante....*/
  { no_ant = aux;
	 aux = aux -> next;
  }

/* trocando pois chegou ao ponto... desejado */
	if( no_ant == aux ) 	/* volta uma celula ... pois
	o novo noh eh o menor dos menores.... */
	/* insere antes do noh-cabeca */
	{ no_ant = no_ant -> prior; }

	novo -> next = aux ;
	novo -> prior = no_ant ;
	aux -> prior = novo ;
	no_ant -> next = novo ;
	L = ache_nova_cabeca(L);
	return;
}

dupla * ache_nova_cabeca(dupla * L)
{ /* por copia */
  dupla * ANC, * cabeca ;
  ANC = L ;

  int menor = L -> idade;
  cabeca = L;

	while( L -> next != ANC )
	{
	  if (menor > (L -> idade)) /* troca */
	  {cabeca = L;}
	  L = L -> next;
	}
	if (menor > (L -> idade)) /* ultimo caso ==> troca */
	  {cabeca = L;}

	return( cabeca );
}
