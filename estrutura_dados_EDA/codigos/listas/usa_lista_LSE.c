// Prototipos etc em ...
#include "lista_LSE.h"

int main(void)
{
   char *vetor_INPUT[] = 
		  {"joao do pulo", "pedro bandeira", 
		   "anita garibaldi", "maria luiza"};
   int Q = 4; 
    
    system("clear");
    printf("\n VETOR %d elementos\n", Q);		
	/** cria um PONTEIRO PARA UMA lista **/
    NOH_tipo_LSE * L; 
    L = NULL; // aqui sim eh necessario ... VAZIA
  
    printf(" ENDERECOS de L:  %p : &L %p" , L , &L );
    printf("\n  1. Compto de Lista:  %d NOSH",  comprimento_lista(&L) );  
    // APLICACAO 1
	for(int i=0; i < Q; i++ )	
	{
     //printf("\n => %d : %d : %s", i, ins_fim_lista( vetor_INPUT[i] , &L ),   vetor_INPUT[i] );
     // &L ... passagem por referencia ... para atualizar L no parâmetro
     ins_fim_lista_2( vetor_INPUT[i] , &L );
    //printf("\n ...inserindo...:  %d: %s" , i, vetor_INPUT[i]);
     };
    printf("\n  2. Compto de Lista:  %d NOSH", comprimento_lista(&L) ); 
    //  APLICACAO 2
	for(int i=0; i < Q; i++ )	
	{
     ins_inic_lista(vetor_INPUT[i] , &L );
    };
    printf("\n  3. Compto de Lista:  %d NOSH", comprimento_lista(&L) );

  // PARA FINS DE TESTES ....	
    imp_lista( L );
    printf("\n  Compto de Lista:  %d NOSH", comprimento_lista(&L) );
    printf("\n  Recursivo 1 Compto de Lista:  %d NOSH", recurs_comp_lista_1( L ));
    printf("\n  Recursivo 2 Compto de Lista:  %d NOSH", recurs_comp_lista_2( &L ));    

/*  Em sala teste ....
    if( exclui_n_esimo_lista( 4 , &L ) )
    printf("\nExclusao com sucesso" ); 
    else
    printf("\nExclusao com INsucesso" );     

    if( exclui_n_esimo_lista( 1 , &L ) )
    printf("\nExclusao com sucesso" ); 
    else
    printf("\nExclusao com INsucesso" );     

    if( exclui_n_esimo_lista( 4 , &L ) )
    printf("\nExclusao com sucesso" ); 
    else
    printf("\nExclusao com INsucesso" );     

    if( exclui_n_esimo_lista( 44 , &L ) )
    printf("\nExclusao com sucesso" ); 
    else
    printf("\nExclusao com INsucesso em 44" );     

   if( exclui_n_esimo_lista( 0 , &L ) )
    printf("\nExclusao com sucesso" ); 
    else
    printf("\nExclusao com INsucesso em 0" );     

    if( inclui_n_esima_lista( 2 , "inclui 2a posicao da lista", &L ))
    printf("\n INCLUSAO 2a posicao com sucesso" ); 
    else
    printf("\nINCLUSAO  com INsucesso" );


   if( inclui_n_esima_lista( 1 , "inclui 1a posicao da lista", &L ))
    printf("\n INCLUSAO 1a posicao com sucesso" ); 
    else
    printf("\nINCLUSAO  com INsucesso" );

    imp_lista( L );

    if( exclui_o_ultimo_lista(  &L ) )
    printf("\nExclusao do ultimo sucesso" ); 
    else
    printf("\nExclusao com INsucesso ULTIMO" );     


	//printf("fim: %p %p\n", L->next, 	ancora->next );
	imp_lista( L );
*/    
	// falta destruir lista
    destroi_lista( &L );
	puts("\n... SUCESSO...");

return 1;
}
