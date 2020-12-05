
#include "lista_LDE.h"

int main(void)
{
   char *vetor_INPUT[] = 
        {"joao do pulo", "pedro bandeira", 
         "anita garibaldi", "maria luiza"};

   int Q = 4; 
    
    system("clear");
    printf("\n VETOR %d elementos\n", Q);		
	/** cria um PONTEIRO PARA UMA lista  = HEADER **/
    NOH_tipo_LDE * h_LDE  = NULL;
     // aqui sim eh necessario ... VAZIA
  
    //printf("ENDERECO:  %p " , h_LDE);
    //printf("\n  Compto de Lista:  %d NOSH", comprimento_lista(&h_LDE) );  
    // APLICACAO 1
	for(int i=0; i < Q; i++ )	
	{
     //printf("\n => %d : %d : %s", i, ins_fim_lista( vetor_INPUT[i] , &L ),     	                              vetor_INPUT[i] );
     insere_fim_lista_2 ( vetor_INPUT[i] , &h_LDE );
//	 printf("\n ...inserindo...:  %d: %s" , i, vetor_INPUT[i]);
    };
    imp_lista( h_LDE );
    
    printf("\n  Comprimento corrente da LDE:  %d NOH(S)", comprimento_lista(&h_LDE) );
//  APLICACAO 2
	for(int i=0; i < Q; i++ )	
	{
     insere_inicio_lista (vetor_INPUT[i] , &h_LDE );
    };
    imp_lista( h_LDE );
    
    printf("\n  Comprimento corrente da LDE:  %d NOH(S)", comprimento_lista(&h_LDE) );
    // PARA FINS DE TESTES ....	

	//printf("fim: %p %p\n", L->next, 	ancora->next );
	//imp_lista( h_LDE );
	// falta destruir lista
    destroi_lista( &h_LDE );


	puts("\n... SUCESSO...");

return 1;
}
