#include <stdio.h>
#include <stdlib.h>

// ALOCACAO ESTATICA
typedef struct stack
	{
	  int topo ;
	  int tam_MAX;  // vira de uma STRING DADA 
	  char * pt_entradas; // em funcao do tamanho desta
	}  tipo_pilha ;

// FALTAM ALGUMAS FUNCOES SEMI-PRONTAS
char * le_entrada_pilha (  tipo_pilha * Pilha ); 
void inicializa_pilha ( tipo_pilha * Pilha);
void carrega_pilha ( char *pt_vetor ,   tipo_pilha * Pilha );

void imprime_pilha ( tipo_pilha * Pilha );

void push (char x, tipo_pilha * P);
void pop (char *x, tipo_pilha * P);
void destroi_pilha ( tipo_pilha * P );
int main(void)
{
	system("clear"); // CUIDADO
    tipo_pilha  PILHA; 
	tipo_pilha  *pt_pilha; /* criar por referencia 
	e nao duplicar os dados.... */
	pt_pilha = &PILHA; 
	char * pt_entrada;

    // le uma entrada e indica o seus tamanho
	pt_entrada  =  le_entrada_pilha ( pt_pilha );
	
	inicializa_pilha ( pt_pilha );
	//Cria e aloca pilha ... mas sem dados
	
	// pega entrada e coloca na PILHA
	carrega_pilha ( pt_entrada , pt_pilha ); // via push
    imprime_pilha ( pt_pilha ); // via pop
    destroi_pilha ( pt_pilha );
    // free( pt_pilha ); ... NAO HOUVE MALLOC EM pt_pilha
   return 1;
  }


// UMA APLICACAO ..... pode estar em um 3o. arquivo

// le algo e define o tam_MAX da pilha ... 
char * le_entrada_pilha (  tipo_pilha * P )
{   // alternativa eh LER e IMEDIATAMENTE CRIAR A PILHA
	char vetor[]= ".XXX."; // QUALQUER COISA AQUI.";
	char *pt_vetor;
	int tam_vetor = (int)sizeof(vetor);
	
	printf("\n QTIDADE DE OBJETOS:::%d", tam_vetor );
	// EIS O DIFERENCIAL  do anterior
	P -> tam_MAX = tam_vetor; // tamanho da pilha especificado
	pt_vetor = &vetor[0];
	return (pt_vetor);
	
}
// conteudo de pt_vetor .... usando push em X
void carrega_pilha ( char *pt_vetor , tipo_pilha * P )
{		
	for(int i=0; i < (P -> tam_MAX) ; i++)
	{    
		push ( *pt_vetor ,  P );
		pt_vetor++ ;
    }
	return;
}

void imprime_pilha ( tipo_pilha * P )
{ 
  char x; /* ou char *pt */
  printf("\n   MOSTRA_PILHA (usando pop): \n");
   while ( P -> topo >= 0 ) // cuidar onde a pilha se inicializa
    {
     pop ( &x , P );
     // printf("Pilha[%d]:%c ||", X -> topo, x);
     // printf("\n Pilha[%d] :: %c", X -> topo, x);
    }
    printf("\n FEITO ... \n")   ;
  return;
}
/************************************************/

