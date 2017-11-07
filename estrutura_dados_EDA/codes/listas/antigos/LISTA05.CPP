#include <stdio.h>
#include <malloc.h>
#include <ctype.h>
#include <string.h>
#include <conio.h>
#include <stdlib.h>

/* Insere no inicio da lista ... criando a lista com um primeiro
	noh na pilha e os demais na heap ... */
typedef struct node
	{
	  char nome[20];
	  struct node *next;
	} no_modelo;

typedef no_modelo  no_tipo;

void ins_lst(char  * x_nome, no_tipo * * L);
no_tipo * cria_no(void);
void imp_lista (no_tipo *L);
void  destroi_lista (no_tipo * &L);

void main(void)
	{
		char resp;
		char texto[20];
		no_tipo  *L_pilha ;
		/* variavel local a main ==> na PILHA */

		printf (" \n Criando uma lista + pointer na PILHA.... (nao na HEAP) ");
		L_pilha = NULL; /* inicializa o ponteiro .... */
		printf ("\n Conteudo:: %x Onde estah:: %x. Conteudo Indireto:: ", L_pilha, &L_pilha);
		//*L_pilha ===> nao pode porque nao foi inicializado

		do
		{
			printf("\n DIGITE NOME: ");
			scanf("%s", texto );
			/* o end de L_pilha eh INVARIAVEL */
			ins_lst(texto, & L_pilha );
			fflush(stdin);
			printf("\n Mais alguem (s ou S): ");
			resp = (char)toupper(getche());
			printf("\n.........................");
		}
		while(resp == 'S');
		imp_lista( L_pilha );
		printf ("\n Conteudo:: %x Onde estah:: %x. Conteudo Indireto:: %x", L_pilha, &L_pilha, *L_pilha );
		destroi_lista( L_pilha );
		imp_lista( L_pilha );

		puts("\n..... SUCESSO......");
	}


void imp_lista(no_tipo *L)
{
	/* quando hah uma chamada .... hah alocacao de todas variaveis...
		 campos etc..... */
	int i=1;

	for( ; (L -> next != NULL); L = L -> next)
	{
	  printf("\n%do. Noh:::  NOME: %s", i, L -> nome);
	  i++;
	}
	printf("\n%do. Noh:::  NOME: %s", i, L -> nome);
	return;
}

void ins_lst( char x_nome[], no_tipo * *L )
 { /* L eh criada com todos os campos.... mas
		nao houve atribuicoes... portanto cuidar...
	*/
	no_tipo * novo_no ;
	novo_no = cria_no ();

	if ((strcpy( novo_no -> nome , x_nome)) == "\0")
	{  /* strcpy returns destino  * char */
		printf("\n Problema na insercao.... na copia do nome");
		getche();
		exit(1);
	}

if ( *L == NULL )
	/* L -> next dah erro */
	/* pois nao hah criacao/alocacao do mesmo na PILHA e HEAP */
		{ /* A LISTA ESTAVA VAZIA ===> 1o. elemento ATERRAR */
			novo_no -> next = NULL;
		}
		else
		{ /* posiciona ateh o fim ===> insercao no inicio */
			novo_no -> next = *L ;
		}
		*L = novo_no;   /* ATUALIZA CABECA ...*/
		printf ("\n Conteudo:: %x Onde estah:: %x. Conteudo Indireto %x:: ", L, &L, *L);
		return;
}

void  destroi_lista (no_tipo * &L )
 {
  int i=0;
  if ( L == NULL)
  {
	 printf("\n A LISTA ESTAVA VAZIA !");
	 return;
	}

	while ( (L -> next) != NULL )
		{
			free( L );
			L = L -> next;
			i++;
		}

	free (L);
	printf("\n Foram liberados %d nos !", i+1);
	return;
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