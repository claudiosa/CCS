#include "pilha_realloc.h"

int main(void)
{
	system("clear"); // CUIDADO
    // le uma entrada
    printf(" DIGITE UMA ENTRADA :") ; // OK
    // UMA APLICACAO ..... pode estar em um 3o. arquivo
     
    char entrada[50] = "aXXXYYz"; // VEM DA APLICACAO

     tipo_pilha * pt_P = inicializa_pilha ( );
	//Cria e aloca pilha ... mas sem dados
	// Da entrada e coloca na PILHA
    carrega_pilha ( & entrada [0] , pt_P ); // via push
    imprime_pilha ( pt_P ); // via pop
    destroi_pilha ( pt_P );
    
   return 1;
  }

//APLICACAO // conteudo de pt_vetor .... usando push em X
void carrega_pilha ( char * pt_vetor , tipo_pilha * P )
{		
	printf("\n LEITURA DA ENTRADA ==> %s \n" , pt_vetor);
	printf("\n \n  CARREGA_PILHA (usando push): \n");
    
	for ( ; *pt_vetor != '\0' ; pt_vetor ++ )
	{    
       push ( *pt_vetor ,  P );
	}
	return;
}

void imprime_pilha ( tipo_pilha * P )
{ 
  char x; /* ou char *pt */
  printf("\n \n   MOSTRA_PILHA (usando pop): \n");
   while ( P -> topo >= 0 ) // cuidar onde a pilha se inicializa
    {
     pop ( &x , P );
     // printf("Pilha[%d]:%c ||", X -> topo, x);
     // printf("\n Pilha[%d] :: %c", X -> topo, x);
    }
    printf("\n ... FEITO ... \n")   ;
  return;
}
/************************************************/
