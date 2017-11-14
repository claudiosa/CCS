#include <stdio.h>
#include <malloc.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <conio.h>

/* Insere no inicio da lista ... deixa parado um no-final
  portanto.... eh uma fila... */
typedef struct node
	{
	  char nome[20];
	  struct node *next;
	} no_modelo;

typedef no_modelo  no_tipo;

no_tipo *  ins_lst_inic(char x_nome[], no_tipo *L);
int is_empty( no_tipo *L );
no_tipo * cria_no(void);
void imp_lista1(no_tipo *L);


void main(void)
	{
		char resp;
		char texto[20];
		no_tipo  *Lista;

		printf (" \n Criando uma lista vazia.... ");
		Lista = cria_no ();
		Lista -> next = NULL;
		strcpy( Lista  -> nome , "...Peh da Lista...");
		printf("\n Tamanho do pointer eh %d", sizeof(Lista));

		do
		{
			printf("\n DIGITE NOME: ");
			scanf("%s", texto );
			if( (Lista = ins_lst_inic(texto, Lista)) == NULL )
			{
				printf(" Nao inseriu .... OK !");
				getchar();
				break;
			}
			fflush(stdin);
			printf("\n Mais alguem (s ou S): ");
			resp = (char)toupper(getche());
			printf("\n.........................");
		}
		while(resp == 'S');
		imp_lista1( Lista );
		puts("\n..... SUCESSO......");
	}

void imp_lista1(no_tipo *L)
{
	int i=1;
	for( ; ((L -> next != NULL) && (i < 17)); L = L -> next)
	{
	  printf("\n%do. Noh:::  NOME: %s", i, L -> nome);
	  i++;
	}
	return;
}

no_tipo * ins_lst_inic( char x_nome[], no_tipo *L )
 {
		no_tipo * novo_no ;
		novo_no = cria_no ();   /* CRIA ==> ALOCA */
		novo_no  -> next = L;   /* NOVA CABECA ...*/
		strcpy( 	novo_no  -> nome , x_nome);
		return( novo_no );     /* NOVA CABECA DA LISTA */
 }

int is_empty( no_tipo *L )
	{
		return( L->next == NULL );
	}
/* se eh o ultimo */
int is_last( no_tipo *p )
{
	return( p->next == NULL );
}

no_tipo * cria_no()
{
 no_tipo  *new_no;
 if((new_no=(no_tipo *)malloc(sizeof(no_tipo))) == NULL)
	{
		printf("\n Erro de alocacao .... ");
		getchar();
		exit(1);
	}
	return(new_no);
}
/******* fim ******/