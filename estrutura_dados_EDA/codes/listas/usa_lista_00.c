#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C
#define N 20

struct NO_struct
	{
	  char nome[N]; // aqui uma outra struct
	  struct NO_struct *next; 
	};

typedef struct NO_struct  noh_tipo;

noh_tipo * cria_no(void);
void ins_lista(char x_nome[], noh_tipo *L);
void insere_lista(char x_nome[], noh_tipo *L);
void imp_lista(noh_tipo *L);


int main(void)
{
   char *vetor_INPUT[] = 
		  {"joao", "pedro henrique", 
		   "anita", "maria luiza"};
    int Q = 4; 
    //(int)sizeof(vetor_INPUT)
    printf("\n VETOR %d elmentos\n", Q);		
	/** cria uma lista **/
    noh_tipo * L;
    L = cria_no(); // vazia
    printf("ENDERECOS: %p %p\n" , L -> next , L);
    printf("\n INICIAL: %s", L  -> nome );
    strcpy( L -> nome , "CABECA");
        printf("\n DEPOIS: %s", L  -> nome );
    
    // APLICACAO
	for(int i=0; i < Q; i++ )	
	{
	  insere_lista( vetor_INPUT[i] , L );
	  printf("\n %d: %s ", i, vetor_INPUT[i] );    
    };
		
	//printf("fim: %p %p\n", L->next, 	ancora->next );
	imp_lista( L );
	puts("\n... SUCESSO...");

return 1;
}

