#include "lista_LCIRC.h"


// UMA PRIMITIVA -- generica a qualquer momento
NOH_tipo_LCIRC * cria_no(void)
{
 NOH_tipo_LCIRC  *new_node;
 new_node = (NOH_tipo_LCIRC *) malloc(sizeof(NOH_tipo_LCIRC)) ;

 if( new_node == NULL)
	{
		printf("\n Erro de alocacao .... falta memoria!");
		getchar();
		exit(1);
	}
	return(new_node);
}

// IMPRIME A LISTA ADAPTADA ... OK
void imp_lista(NOH_tipo_LCIRC *pt_L) // UMA COPIA 
{ 
  puts("\n IMPRIME LISTA: \n ============================");
  int i=1;
 // printf("\n %d o. Noh:::  NOME: %s", i , ( L -> nome));
  NOH_tipo_LCIRC * cabeca = pt_L ;
 if( pt_L == NULL ) // caso L nao esteja enderecado a lugar algum
  {
  	printf("\n LISTA VAZIA .....");
  	return;
  }

  do {
	  printf("\n %do. Noh  NOME: %s", i , ( pt_L -> pt_nome) );
	  pt_L = pt_L -> next ;
      i++;
	} while( pt_L != cabeca ) ;
	
  return;
}

// insere no inicio da lista -- NAO
int insere_inicio_lista(char *pt_DADO, NOH_tipo_LCIRC ** header_L) 
{
    NOH_tipo_LCIRC * new_node, * corrente;
//    new_node = (NOH_tipo_LCIRC *) malloc(sizeof(NOH_tipo_LCIRC));
    new_node = cria_no();

   if( (*header_L) == NULL )
   {
     new_node -> pt_nome = pt_DADO; 
     new_node -> next = new_node;
     (*header_L) = new_node;
    // lista vazia um no inserido
     return 11;
   }

   // Avanca ate o final da lista
   corrente = (*header_L);
   while(corrente -> next != (*header_L) )
   {
   	 corrente = corrente -> next;
   } ;

    // 
    new_node -> pt_nome = pt_DADO; // DADO
    corrente -> next = new_node; // o ultimo aponta para o novo noH
    new_node -> next = (*header_L); // para o lugar onde head estava
    (*header_L) = new_node ; // atualiza
    return 22;

}

// insere DADO x_nome a lista -- OK
int insere_final_lista(char *pt_DADO, NOH_tipo_LCIRC ** L)
 { // insere ao final da lista

    if( (*L) == NULL ) // caso L nao esteja enderecado a lugar algum
    {
		NOH_tipo_LCIRC * novo_no = cria_no ();
		//se lista vazia ... esta vai comecar em ..
		(*L) = novo_no;
		//printf("CONTEUDO de L:  %p\n" , *L);
		//strcpy( novo_no  -> nome , x_nome);
		novo_no  -> pt_nome = pt_DADO;
		novo_no  -> next = novo_no; 
		/* INSTANCIA  inicialmente para ele	proprio */
		return 11; // UMA VEZ
	}	
    else
    {	
    	NOH_tipo_LCIRC * novo_no , * aux ;
	    aux = (*L); // inicio da lista
		for( ; aux -> next != (*L) ; )
			aux = aux -> next ;
		
		novo_no = cria_no ();   /* CRIA ==> ALOCA */
		novo_no  ->  pt_nome = pt_DADO;
		novo_no  ->  next = (*L); /* INSTANCIA  inicialmente como ultimo */
		aux -> next = novo_no; // atualiza o ultimo em L 
        // novo_no e o ultimo nao perde L
		return 22;
	}
}	

// erradp
int is_empty( NOH_tipo_LCIRC *L )
	{
		return( L == NULL );
	}

/* se eh o ultimo */
int is_last( NOH_tipo_LCIRC *L )
{
	return( L->next == NULL );
}

// ADAPTADA ... OK
void destroi_lista( NOH_tipo_LCIRC **L )
  {
   if( (*L) != NULL )
  	 { int i=1;
  	   NOH_tipo_LCIRC  * aux , *prox;
  	   aux =(*L);
	  	  while( aux -> next != (*L) ) 
	  	  {
		  	prox = aux -> next;
		  	//free( aux ->  pt_nome );  NAO .....
		  	free(aux); // AQUI LIBERA TUDO 
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


// ADAPTADA OK
int comprimento_lista( NOH_tipo_LCIRC **L )
  {
   if( (*L) == NULL )
   return 0;
  
    int i=1; // UM NO
    // PODE SER SIMPLIFICADO 
  	NOH_tipo_LCIRC  * aux ;
  	aux = (*L);
	  	while( aux -> next != (*L) ) 
	  	 {
		  aux = aux -> next;
		  //puts(".");
	      i++;
	} ;
		      
     // da para fazer sem *prox  
    //printf("\n Comprimento da lista: %d ", i );
  
    return i;
         
  }



/*
 BEM TRABALHOSA .... estudem todos os casos possiveis
 3 casos possiveis ... pode ser melhorada

*/  
bool exclui_n_esimo_lista( int n_posicao, NOH_tipo_LCIRC **L )
  {
   int Kompto_L  =	comprimento_lista( L );
   if( (n_posicao > Kompto_L || n_posicao < 1) || Kompto_L  <= 0)
   {
	  printf("\n Erro na exclusao da n-esima posicao ... INVALIDA=>  %d", n_posicao);
	  getchar();
	  return false;
	};
	
    int i=1; // UM contador de NO
  	NOH_tipo_LCIRC  * corrente , *anterior, *ultimo;
  	corrente = (*L) ; // isto eh melhor depois

    //OK ...  desnecessario  = testar
	if( Kompto_L == 1) // caso de excluir a cabeca  da lista
   	{
	  printf("\n Zero) NOH: %d => EXCLUINDO NOME: %s", i, ( corrente -> pt_nome));
      free(corrente);
      (*L) = NULL;
      return true;
    }; 

     /* 3 situacoes

     1. remover o 1o. noh da lista (tem que achar o final)
     2. remover o ultimo da lista (tem que achar o final)
     3. remover do 2o. no ao penultimo da lista

     */

    if( n_posicao == 1) // caso de excluir a cabeca  da lista
   	{
     // indo ao final da lista
   	while( corrente -> next != (*L) ) // ir ate a ultima posicao
      {
       corrente  = corrente -> next;
      } 
      // anterior eh o ULTIMO
      ultimo = corrente;
      corrente  = corrente -> next; // vai para o 1o. no a ser excluido
      printf("\n A) NOH: %d => EXCLUINDO NOME: %s", i, ( corrente -> pt_nome));
      //(*L) = corrente ; // ASSIM ....
      (*L) = (*L) -> next  ; // atualiza cabeca da lista
      ultimo -> next = (*L);
      free(corrente);
      return true;
    } ; // fim de eliminar o cabeca da lista


	// Eliminar o ultimo da lista
    if( n_posicao == Kompto_L) // caso de excluir a cabeca  da lista
   	{
     // indo ao final da lista
     while( corrente -> next != (*L)) // ir ate a ultima posicao
      { // CUIDAR A ORDEM DO ANTERIOR
       anterior  = corrente;
       corrente  = corrente -> next;
       i++;  
     } 
       
 	// anterior eh ULTIMO
      printf("\n B) NOH: %d => EXCLUINDO NOME: %s", i, ( corrente -> pt_nome));
      anterior -> next = corrente -> next;
      free(corrente);
      return true;
    } ; // fim de eliminar o ultimo da lista

    // 3o. CASO ... entre o 2a posicao e ultimo no
    if( (n_posicao > 1 ) && (n_posicao < Kompto_L)  )
   	{
       // indo ao final da lista
	     while( i < n_posicao) // ir ate a ultima posicao
	      {
	       anterior  = corrente;
	       corrente  = corrente -> next;
	       i++;  
	      } 
	       
 	// anterior eh ULTIMO
      printf("\n C) NOH: %d => EXCLUINDO NOME: %s", i, ( corrente -> pt_nome));
      anterior -> next = corrente -> next;
      free(corrente);
      return true;
     } 
     /* 
      printf("\n c) NOH: %d => anterior: %s", i, ( anterior -> pt_nome));
      printf("\n c) NOH: %d => EXCLUINDO NOME: %s", i, ( corrente -> pt_nome));
    */
     else
    {
	  printf("\n ALGUME erro na exclusao da n-esima posicao ... L_CIRCULAR");
	  getchar();
	  return false;
	};

  }    

//  Reusando a exclusao do N-esimo  
bool exclui_o_ultimo_lista(  NOH_tipo_LCIRC **header_L )
 {
   int posicao_ultimo = comprimento_lista( &(*header_L) );
   return ( exclui_n_esimo_lista( posicao_ultimo , &(*header_L) ));
   // SINTAXE ESTRANHA ... mas era o endereço do ponteiro do header LISTA original
   // ilustra o REUSO de METODOS
 }


 // Insercao na N-esima posicao .... 
//  NAO ESTA PRONTO para LCIRCULAR
bool inclui_n_esima_lista( int n, char *pt_DADO, NOH_tipo_LCIRC **head_L )
  {

   if( n > comprimento_lista( head_L ) || n < 1)
   {
	  printf("\n Erro na inclusao .... posicao INVALIDA!");
	  getchar();
	  return false;
	}
	
    int i=1; // UM NO
    NOH_tipo_LCIRC * new_node;
    new_node = (NOH_tipo_LCIRC *) malloc(sizeof(NOH_tipo_LCIRC));

  	NOH_tipo_LCIRC  * corrente , *anterior;
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
