#include "lista_LSE.h"


// UMA PRIMITIVA -- generica a qualquer momento
NOH_tipo_LSE * cria_no(void)
{
 NOH_tipo_LSE  *new_node;
 new_node = (NOH_tipo_LSE *) malloc(sizeof(NOH_tipo_LSE)) ;

 if( new_node == NULL)
	{
		printf("\n Erro de alocacao .... falta memoria!");
		getchar();
		exit(1);
	}
	return(new_node);
}

// IMPRIME A LISTA
// vem o endereco original .... 
void imp_lista(NOH_tipo_LSE *L)
{ 
  puts("\n IMPRIME LISTA: \n ============================");
  int i=1;
 // i ... apenas para uma saida mais cabrichada
  do {
	  printf("\n %do. Noh  NOME: %s", i , ( L -> pt_nome));
	  printf("\t END: %p ", L ); // cuidar aqui ...
	  //printf("distancia entre nos: %X \n", p->lista - p->lista->prox);
	  L = L -> next;
      i++;
	} while( L != NULL );  
	
	return;
}

// insere no inicio
void ins_inic_lista(char *pt_DADO, NOH_tipo_LSE ** head) 
{
    NOH_tipo_LSE * new_node;
    new_node = (NOH_tipo_LSE *) malloc(sizeof(NOH_tipo_LSE));

    //new_node-> x_nome = val;
    new_node  -> pt_nome = pt_DADO;
    new_node -> next = (*head);// para o lugar onde head estava
    (*head) = new_node ;
}

// insere DADO x_nome na lista
int ins_fim_lista(char *pt_DADO, NOH_tipo_LSE ** L)
 { // insere ao final da lista

    if( (*L) == NULL ) // caso L nao esteja enderecado a lugar algum
    {
		NOH_tipo_LSE * novo_no = cria_no ();
		//se lista vazia ... esta vai comecar em ..
		(*L) = novo_no;
		//printf("CONTEUDO de L:  %p\n" , *L);
		//strcpy( novo_no  -> nome , x_nome);
		novo_no  -> pt_nome = pt_DADO;
		novo_no -> next = NULL; /* INSTANCIA  inicialmente o ultimo */
		return 11; // 11 apenas para indicar que a lista era vazia
	}	
    else
    {	
    	NOH_tipo_LSE * novo_no , * aux ;
	    aux = (*L); // inicio da lista
		for( ; aux -> next != NULL ; )
			aux = aux -> next ;
		
		novo_no = cria_no ();   /* CRIA ==> ALOCA */
		novo_no  -> pt_nome = pt_DADO;
		novo_no -> next = NULL; /* INSTANCIA  inicialmente como ultimo */
		aux -> next = novo_no; // atualiza o ultimo em L 
        // novo_no e o ultimo nao perde L
		return 22; // caso geral
	}
}	
// insere SIMPLIFICADO sem os codigos de retorno
void ins_fim_lista_2(char *pt_DADO,  NOH_tipo_LSE **L )
 {
   /* vai ser inserido no final da lista */
  if( (*L) == NULL ) // caso L nao esteja enderecado a lugar algum
    {
		NOH_tipo_LSE * novo_no = cria_no ();
		//se lista vazia ... esta vai comecar em ..
		(*L) = novo_no;
		//strcpy( novo_no  -> nome , x_nome);
		novo_no  -> pt_nome = pt_DADO;
		novo_no -> next = NULL; /* INSTANCIA  inicialmente o ultimo */
		return ;
	}	
    else
    {	
    	NOH_tipo_LSE * novo_no , * aux ;
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

// Consertado ....
bool esta_vazia( NOH_tipo_LSE **L )
	{
		return(  (*L) == NULL  );
	}

/* se eh o ultimo  ..... MELHORAR ..... pois nao eh caso*/
int is_last( NOH_tipo_LSE *L )
{
	return( L->next == NULL );
}

void destroi_lista( NOH_tipo_LSE **L )
  {
   if( (*L) != NULL )
  	 { int i=1;
  	   NOH_tipo_LSE  * aux , *prox;
  	   aux =(*L);
	  	  while( aux -> next != NULL ) 
	  	  {
		  	prox = aux -> next;
		  	//free( aux ->  pt_nome );  NAO .....
		  	free(aux); // AQUI LIBERA aux
		  	aux = prox;
		  	//puts(".");
	      	i++;
		  } ;
		      
       free( aux ); // PARA O ULTIMO NO
       printf("\n Total de nosh liberados: %d ", i );
       printf("\n LISTA LIBERADA OK\n " );

       return;
       }

     else
     {
        printf("\n LISTA VAZIA ... NADA a LIBERAR \n" );
        return;
     }
    
  }


// 
int comprimento_lista( NOH_tipo_LSE **L )
  {
   if( (*L) == NULL )
   return 0;
  
    int i=1; // UM NO
  	   NOH_tipo_LSE  * aux ;
  	   aux =(*L);
	  	  while( aux -> next != NULL ) 
	  	  {
		  	aux = aux -> next;
		  	//puts(".");
	      	i++;
		  } ;
		      
     
       //printf("\n Comprimento da lista: %d ", i );
  
       return i;
         
  }


bool exclui_n_esimo_lista( int n, NOH_tipo_LSE **L )
  {
   if( n > comprimento_lista( L ) || n < 1)
   {
	  printf("\n Erro na exclusao da n-esima posicao ... INVALIDA=>  %d", n);
	  getchar();
	  return false;
	}
	
    int i=1; // UM NO
  	NOH_tipo_LSE  * corrente , *anterior;
  	corrente = anterior = (*L);

	if( n == 1) // caso do 1o. da lista
   	{
	  printf("\n NOH: %d => EXCLUINDO NOME: %s", i, ( corrente -> pt_nome));
      (*L) = corrente -> next;
      free(corrente);
      return true;
	}
	// OS DEMAIS ... CREIO QUE PODE SER MELHORADO
    while( i < n ) // avancar ate o no em questao
	 {
	   anterior = corrente;
	   corrente = corrente -> next ; // avanca
	    i++;
	 } ;
		      
    anterior -> next = corrente -> next ;
	printf("\n NOH: %d => EXCLUINDO NOME: %s", i, ( corrente -> pt_nome));
    
    free(corrente);
    return true;
         
  }

// REUSO DE METODOS -- BOM EXEMPLO
bool exclui_o_ultimo_lista(  NOH_tipo_LSE **header_L )
 {
   int posicao_ultimo = comprimento_lista( &(*header_L) );
   return ( exclui_n_esimo_lista( posicao_ultimo , &(*header_L) ));
   // SINTAXE ESTRANHA ... mas era o endereço do ponteiro do header LISTA original
   // ilustra o REUSO de METODOS
 }


 // Insercao na N-esima posicao .... 

bool inclui_n_esima_lista( int n, char *pt_DADO, NOH_tipo_LSE **head_L )
  {

   if( n > comprimento_lista( head_L ) || n < 1)
   {
	  printf("\n Erro na inclusao .... posicao INVALIDA!");
	  getchar();
	  return false;
	}
	
    int i=1; // UM NO
    NOH_tipo_LSE * new_node;
    new_node = (NOH_tipo_LSE *) malloc(sizeof(NOH_tipo_LSE));

  	NOH_tipo_LSE  * corrente , *anterior;
  	corrente = anterior = (*head_L);

	if( n == 1) // caso do 1o. da lista
   	{
    //new_node-> x_nome = val;
     new_node  -> pt_nome = pt_DADO;
     new_node -> next = (*head_L);
     // para o primeiro da lista  onde head estava apontando
     (*head_L) = new_node ; // atualiza head
      return true;
	}
	// OS DEMAIS ... CREIO QUE PODE SER MELHORADO
    while( i < n ) // avancar ate o no em questao
	 {
	   anterior = corrente;
	   corrente = corrente -> next ; // avanca
       i++;
	 } ;

    new_node  -> pt_nome = pt_DADO;		      
    anterior -> next = new_node ;
    new_node -> next = corrente ;
	    
    return true;
         
  }

/******* fim ******/
