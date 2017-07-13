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
 void imp_lista1(dupla *L);
 void destroi_lista (dupla * * L );
 dupla * cria_no( void);

 void main(void)
{
	int vetor[]= { 2,5,110,99,-17,54,1,2,-9};
	int i;
	dupla  *L; /* APENAS NA PILHA ... NOH ESTATICO*/
	L = NULL;
	int max =(int)sizeof(vetor)/sizeof(int);

	for(i=0; i < max ; i++)
	ins_ord( vetor[i], L);

	imp_lista1(L);
	destroi_lista( &L );
}

void  ins_ord(int x, dupla * &L)
{
	dupla * no_ant, * novo, * aux;
	novo = cria_no();

	novo -> idade = x; /* atribui valor */

	aux = no_ant = L; /* aux == noh_corrente */

 if(aux == NULL) /* no caso de nada na HEAP */
 {
	novo -> next =  NULL;
	novo -> prior = NULL;
	L = novo;
	return;
  }

while((x > (aux -> idade)) && ( aux -> next != NULL) )
/* enquanto o noh corrente for menor que o valor a ser inserido...
	entao vah adiante....*/
  {
	 no_ant = aux;
	 aux = aux -> next;
	}

/* trocando pois chegou ao ponto... desejado */
 if ((aux->prior == NULL) && x<(aux ->idade))
	{ /* insercao no inicio */
	novo -> next = aux ;
	novo -> prior = aux -> prior; /* que eh NULL*/
	aux -> prior = novo ;
	L = novo;
	return;
	}

if (( aux -> next == NULL )&& x > (aux -> idade) )
	{ /* insercao no final */
	novo -> next = aux -> next; /* que eh NULL*/
	novo -> prior = aux;
	aux -> next = novo;
	return;
	}

/* insercao em algum lugar... depois do no_ant */
if(( aux -> next != NULL)||(aux -> prior != NULL))
	{
	novo -> next = aux; /* o da frente */
	novo -> prior = aux -> prior;
	aux -> prior = novo;
	no_ant -> next = novo;
	return;
	}

}
