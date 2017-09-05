#include <stdio.h>
#include <stdlib.h>
//#include <string.h>
// ALOCACAO DINAMICA
// se DUVIDAS -> https://www.ime.usp.br/~pf/algoritmos/aulas/footnotes/typedef.html

typedef struct
	{
	  int topo ;
      int tam_MAX;  // vira de uma STRING DADA #include <string.h>
	  char * entradas; // em funcao do tamanho desta
	}  tipo_pilha ;

// FALTAM ALGUMAS FUNCOES SEMI-PRONTAS
// char * le_entrada_pilha (  tipo_pilha * Pilha ); 
char * le_uma_entrada (  void );
// diferente aqui tambem
tipo_pilha * inicializa_pilha (void);

void carrega_pilha ( char *pt_vetor ,   tipo_pilha * Pilha );

void imprime_pilha ( tipo_pilha * Pilha );
int pilha_cheia  (tipo_pilha * P);
void push (char x, tipo_pilha * P);
void pop (char *x, tipo_pilha * P);
void destroi_pilha ( tipo_pilha * P );
void aumenta_pilha(tipo_pilha * P);
int main(void)
{
	system("clear"); // CUIDADO
	
    // le uma entrada
    char *  pt_entrada = "aXXXz"; // VEM DA APLICACAO

//	  pt_entrada  =  le_uma_entrada ( );
//    printf("===> \n %s \n" , pt_entrada); // OK
    
    tipo_pilha * pt_P = inicializa_pilha ( );
	//Cria e aloca pilha ... mas sem dados
	//printf("\n OK %s \n" , pt_entrada );
	// pega entrada e coloca na PILHA
	carrega_pilha ( pt_entrada , pt_P ); // via push
    imprime_pilha ( pt_P ); // via popstrlenstrlen
    destroi_pilha ( pt_P );
    // free( pt_pilha ); ... NAO HOUVE MALLOC EM pt_pilha
   return 1;
  }


// UMA APLICACAO ..... pode estar em um 3o. arquivo

// le algo e define o tam_MAX da pilha ... 
char * le_uma_entrada ( void )
{   // alternativa eh LER e IMEDIATAMENTE CRIAR A PILHA
	char vetor[]= "aXXXz"; // QUALQUER COISA AQUI.";
	char *pt_vetor;
	int tam_vetor = (int)sizeof(vetor);
	// aqui um scanf ou gets
	printf("\n QTIDADE DE OBJETOS:::%d", tam_vetor );
	pt_vetor = &vetor[0];
	//printf("\n %s \n" , vetor); // OK
	//printf("\n %s \n" , pt_vetor); // OK
	return(pt_vetor) ;
}

//// conteudo de pt_vetor .... usando push em X
void carrega_pilha ( char * pt_vetor , tipo_pilha * P )
{		
	printf("\n==> %s \n" , pt_vetor);
	printf("\n \n   CARREGA_PILHA (usando push): \n");
    
	// for( ; *pt_vetor != '\0' ; pt_vetor ++ )
    // printf("%c " , *pt_vetor);
    // printf("\n %s \n" , pt_vetor);

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
    printf("\n FEITO ... \n")   ;
  return;
}
/************************************************/