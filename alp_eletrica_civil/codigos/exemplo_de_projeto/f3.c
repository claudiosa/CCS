#include "minhas_funcoes.h"

int f_calcula(int vetor[N])
{
    // LEITURA DO VETOR 
    int i;
    int VAR_soma = 0;
	for( i=0; i < N ; i++){
       VAR_soma = f_soma(VAR_soma, vetor[i]);
	   }
    
return VAR_soma;
}
