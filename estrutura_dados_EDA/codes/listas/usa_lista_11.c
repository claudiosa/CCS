
#include "lista_11.h"


int main(void)
{
   char *vetor_INPUT[] = 
		  {"joao paulo", "pedro henrique", 
		   "anita garibaldi", "maria luiza"};
    int Q = 4; 
    
    system("clear");
    printf("\n VETOR %d elementos\n", Q);		
	/** cria um PONTEIRO PARA UMA lista **/
    noh_tipo * L; 
    L = NULL; // aqui sim eh necessario ... VAZIA
  
    printf("ENDERECO:  %p " , L);
    printf("\n  Compto de Lista:  %d NOSH", comprimento_lista(&L) );  
    // APLICACAO 1
	for(int i=0; i < Q; i++ )	
	{
     //printf("\n => %d : %d : %s", i, ins_fim_lista( vetor_INPUT[i] , &L ),     	                              vetor_INPUT[i] );
     ins_fim_lista_2( vetor_INPUT[i] , &L );
//	 printf("\n ...inserindo...:  %d: %s" , i, vetor_INPUT[i]);
  //   printf("\n  Compto de Lista:  %d NOSH", comprimento_lista(&L) );
    };

//  APLICACAO 2
	for(int i=0; i < Q; i++ )	
	{
     ins_inic_lista(vetor_INPUT[i] , &L );
    };
	
    imp_lista( L );
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
    printf("\nExclusao com INsucesso" );     

if( exclui_n_esimo_lista( 0 , &L ) )
    printf("\nExclusao com sucesso" ); 
    else
    printf("\nExclusao com INsucesso" );     


	//printf("fim: %p %p\n", L->next, 	ancora->next );
	imp_lista( L );
	// falta destruir lista
    destroi_lista( &L );

	puts("\n... SUCESSO...");

return 1;
}
