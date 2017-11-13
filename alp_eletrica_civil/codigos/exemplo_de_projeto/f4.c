#include "minhas_funcoes.h"

void f_le(int vetor[N])
{
    // LEITURA DO VETOR 
    int i;
	for( i=0; i < N ; i++){
       scanf("%d ", &vetor[i]);
       printf("\t LEU vetor[%d]: %d", i,  vetor[i]);
	   }
    printf("\n\n ======================================\n\n ");
return ;
}
