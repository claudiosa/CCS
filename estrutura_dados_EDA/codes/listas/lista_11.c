#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C


// DEFINICAO DO NO de lista
struct NO_struct
  {
    //char nome[N]; // aqui uma outra struct
    char *pt_nome;
    struct NO_struct *next; 
  };

typedef struct NO_struct  noh_tipo;

noh_tipo * cria_no(void);
int ins_fim_lista(char *pt_nome, noh_tipo **L);
void ins_fim_lista_2(char *pt_DADO , noh_tipo **L);
void imp_lista(noh_tipo *L);
void ins_inic_lista(char *pt_nome, noh_tipo ** head);

// UMA PRIMITIVA -- generica a qualquer momento
noh_tipo * cria_no(void)
{
 noh_tipo  *new_node;
 new_node = (noh_tipo *) malloc(sizeof(noh_tipo)) ;

 if( new_node == NULL)
	{
		printf("\n Erro de alocacao .... falta memoria!");
		getchar();
		exit(1);
	}
	return(new_node);
}

// IMPRIME A LISTA
// vem o endereco original
void imp_lista(noh_tipo *L)
{ 
  puts("\n IMP LISTA: \n");
  int i=1;
 // printf("\n %d o. Noh:::  NOME: %s", i , ( L -> nome));
  do {
	  printf("\n %do. NO  NOME: %s", i , ( L -> pt_nome));
	  L = L -> next;
      i++;
	} while( L  != NULL );
	//while(L -> next != NULL);
	
	return;
}

// insere no inicio
void ins_inic_lista(char *pt_DADO, noh_tipo ** head) 
{
    noh_tipo * new_node;
    new_node = (noh_tipo *) malloc(sizeof(noh_tipo));

    //new_node-> x_nome = val;
    new_node  -> pt_nome = pt_DADO;
    new_node -> next = (*head);// para o lugar onde head estava
    (*head) = new_node ;
}

// insere DADO x_nome na lista
int ins_fim_lista(char *pt_DADO, noh_tipo ** L)
 { // insere ao final da lista

    if( (*L) == NULL ) // caso L nao esteja enderecado a lugar algum
    {
		noh_tipo * novo_no = cria_no ();
		//se lista vazia ... esta vai comecar em ..
		(*L) = novo_no;
		//printf("CONTEUDO de L:  %p\n" , *L);
		//strcpy( novo_no  -> nome , x_nome);
		novo_no  -> pt_nome = pt_DADO;
		novo_no -> next = NULL; /* INSTANCIA  inicialmente o ultimo */
		return 11;
	}	
    else
    {	
    	noh_tipo * novo_no , * aux ;
	    aux = (*L); // inicio da lista
		for( ; aux -> next != NULL ; )
			aux = aux -> next ;
		
		novo_no = cria_no ();   /* CRIA ==> ALOCA */
		novo_no  -> pt_nome = pt_DADO;
		novo_no -> next = NULL; /* INSTANCIA  inicialmente como ultimo */
		aux -> next = novo_no; // atualiza o ultimo em L 
        // novo_no e o ultimo nao perde L
		return 22;
	}
}	
// insere SIMPLIFICADO sem os codigos de retorno
void ins_fim_lista_2(char *pt_DADO,  noh_tipo **L )
 {
   /* vai ser inserido no final da lista */
  if( (*L) == NULL ) // caso L nao esteja enderecado a lugar algum
    {
		noh_tipo * novo_no = cria_no ();
		//se lista vazia ... esta vai comecar em ..
		(*L) = novo_no;
		//strcpy( novo_no  -> nome , x_nome);
		novo_no  -> pt_nome = pt_DADO;
		novo_no -> next = NULL; /* INSTANCIA  inicialmente o ultimo */
		return ;
	}	
    else
    {	
    	noh_tipo * novo_no , * aux ;
	    aux = (*L); // inicio da lista
		for( ; aux -> next != NULL ; )
			aux = aux -> next ;
		
		novo_no = cria_no ();   /* CRIA ==> ALOCA */
		novo_no  -> pt_nome = pt_DADO;
		novo_no -> next = NULL; /* INSTANCIA  inicialmente o ultimo */
		aux -> next = novo_no; // modifica em L 
        // novo_no e o ultimo nao perde L
		return ;
	}
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
