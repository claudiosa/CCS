#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// ALOCACAO DINAMICA

typedef struct
	{
	  int topo ;
      int tam_MAX;  // vira de uma STRING DADA #include <string.h>
	  char * entradas; // em funcao do tamanho desta
	}  tipo_pilha ;

/*
OU Diretamente
struct 
  {
    int topo ;
    int tam_MAX;
    char * pt_entradas;
  }  tipo_pilha ;

*/  

// ALGUMAS FUNCOES SEMI-PRONTAS
tipo_pilha * inicializa_pilha (void);
void carrega_pilha ( char * pt_vetor , tipo_pilha * P );
void imprime_pilha ( tipo_pilha * Pilha );
int  pilha_cheia  (tipo_pilha * P);
void push (char x, tipo_pilha * P);
void pop (char *x, tipo_pilha * P);
void destroi_pilha ( tipo_pilha * P );
int pilha_cheia  (tipo_pilha * P);
int pilha_vazia  (tipo_pilha * P);
/* *************************************************/
