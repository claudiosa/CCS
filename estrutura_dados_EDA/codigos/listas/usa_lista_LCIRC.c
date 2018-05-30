
// =============================================================== //
#include "lista_LCIRC.h"

int main(void)
{
   char *vetor_INPUT[] = 
        {"joao do pulo", "pedro bandeira", 
         "anita garibaldi", "maria luiza"};

   int Q = 4; 
    
    system("clear");
    printf("\n VETOR %d elementos\n", Q);		
	/** cria um PONTEIRO PARA UMA lista  = HEADER **/
    NOH_tipo_LCIRC * header_LCIRC  = NULL;
     // aqui sim eh necessario ... VAZIA
  
    //printf("ENDERECO:  %p " , header_LCIRC);
    //printf("\n  Compto de Lista:  %d NOSH", comprimento_lista(&header_LCIRC) );  
    // APLICACAO 1
	for(int i=0; i < Q; i++ )	
	{
     printf("\n => %d : %d : %s", i, 
                  insere_final_lista ( vetor_INPUT[i] , &header_LCIRC ) ,
                  vetor_INPUT[i] );
   
    };
    imp_lista( header_LCIRC );
    
    printf("\n  Comprimento corrente da LDE:  %d NOH(S)", comprimento_lista(&header_LCIRC) );
//  APLICACAO 2
	for(int i=0; i < Q; i++ )	
	{
     printf("\n => %d : %d : %s", i, 
        insere_inicio_lista (vetor_INPUT[i] , &header_LCIRC ),
        vetor_INPUT[i]);
    };
    imp_lista( header_LCIRC );
    
    exclui_n_esimo_lista( 4, &header_LCIRC );
    printf("\n  Comprimento corrente da LDE:  %d NOH(S)", comprimento_lista(&header_LCIRC) );
  
    exclui_n_esimo_lista( 1, &header_LCIRC ); // 1o. lista
    printf("\n  Comprimento corrente da LDE:  %d NOH(S)", comprimento_lista(&header_LCIRC) );
    
   // exclui_n_esimo_lista( 11, &header_LCIRC );
 
    exclui_n_esimo_lista( 6, &header_LCIRC ); // o ultimo
   // printf("\n  Comprimento corrente da LDE:  %d NOH(S)", comprimento_lista(&header_LCIRC) );

    exclui_n_esimo_lista( 2, &header_LCIRC ); // 1o. lista
    printf("\n  Comprimento corrente da LDE:  %d NOH(S)", comprimento_lista(&header_LCIRC) );
 
    exclui_n_esimo_lista( 1, &header_LCIRC ); // 1o. lista
    printf("\n  Comprimento corrente da LDE:  %d NOH(S)", comprimento_lista(&header_LCIRC) );
  
    exclui_o_ultimo_lista(  &header_LCIRC ); // ULTIMO
     printf("\n\n Finalmente USO do  exclui_o_ultimo_lista  restam %d NOH(S) na lista ", comprimento_lista(&header_LCIRC) );
    // PARA FINS DE TESTES ....	

	//printf("fim: %p %p\n", L->next, 	ancora->next );
	imp_lista( header_LCIRC );
	// falta destruir lista
    destroi_lista( &header_LCIRC );

	puts("\n... SUCESSO...");

return 1;
}
