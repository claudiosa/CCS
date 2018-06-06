#include "lista_00.h"

// UMA PRIMITIVA -- generica a qualquer momento
noh_tipo * cria_no(void)
{
 noh_tipo  *new_node;
 new_node = (noh_tipo *) malloc(sizeof(noh_tipo)) ;
 //new_node -> next == NULL ; //aterrando
 if( new_node == NULL)
	{
		printf("\n Erro de alocacao .... ");
		getchar();
		exit(1);
	}
	return(new_node);
}

// IMPRIME A LISTA vem apenas o endereco original
void imp_lista(noh_tipo *L)
{ 
  puts("\n imp_lista: \n");
  int i=1;
 // printf("\n %d o. Noh:::  NOME: %s", i , ( L -> nome));
  do {
	  printf("\n %do. NO  NOME: %s", i , ( L -> nome));
	  L = L -> next;
      i++;
	} while( L  != NULL );
	//while(L -> next != NULL);
	
	return;
}

// insere DADO x_nome na lista
void ins_lista(char x_nome[], noh_tipo *L)
 {
//  MELHORAR no futuro
//	    printf("%s \t", x_nome);
		/* vai ser inserido no final da lista */
		// ha uma primeira posicao desocupada

		noh_tipo * novo_no , * aux ;
	    aux = L;
		for( ; aux -> next != NULL ; )
			aux = aux -> next ;
		
		novo_no = cria_no ();   /* CRIA ==> ALOCA */
		strcpy( novo_no  -> nome , x_nome);
		novo_no -> next = NULL; /* INSTANCIA  inicialmente o ultimo */
		aux -> next = novo_no; // modifica em L 
        // novo_no e o ultimo
        // nao perde L
		return ;
	}
// insere SIMPLIFICADO
void insere_lista(char x_nome[], noh_tipo *L)
 {
	/* vai ser inserido no final da lista */
	 for( ; L -> next != NULL ; )
		L = L -> next ;
	
	noh_tipo * novo_no = cria_no ();   /* CRIA ==> ALOCA */
	strcpy( novo_no  -> nome , x_nome);
	novo_no -> next = NULL; /* INSTANCIA  inicialmente o ultimo */
	L -> next = novo_no; // modifica em L 
	return ;
	}

// erradp
int is_empty( noh_tipo *L )
	{
		return( L->next == NULL );
	}

/* se eh o ultimo */
int is_last( noh_tipo *p )
{
	return( p->next == NULL );
}

/******* fim ******/
