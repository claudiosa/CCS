#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C

struct NO_struct
	{
	  //char nome[N]; // aqui uma outra struct
	  char *pt_nome;
	  struct NO_struct *next; 
	};

typedef struct NO_struct  noh_tipo;

noh_tipo * cria_no(void);
int  ins_fim_lista  (char *pt_ENTRADA, noh_tipo **L);
void ins_inic_lista (char *pt_ENTRADA, noh_tipo **L);
void ins_fim_lista_2(char *pt_ENTRADA, noh_tipo **L);
void imp_lista(noh_tipo *L);


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
    
    // APLICACAO 1
	for(int i=0; i < Q; i++ )	
	{
     //printf("\n => %d : %d : %s", i, ins_fim_lista( vetor_INPUT[i] , &L ),     	                              vetor_INPUT[i] );
     ins_fim_lista_2( vetor_INPUT[i] , &L );
	 printf("\n ...inserindo...:  %d: %s\n" , i, vetor_INPUT[i]);
    };

//  APLICACAO 2
	for(int i=0; i < Q; i++ )	
	{
     ins_inic_lista(vetor_INPUT[i] , &L );
    };
		
	//printf("fim: %p %p\n", L->next, 	ancora->next );
	imp_lista( L );
	// falta destruir lista
	puts("\n... SUCESSO...");

return 1;
}
