#include <stdio.h>
#include <stdlib.h>

// ALOCACAO ESTATICA
// se DUVIDAS -> https://www.ime.usp.br/~pf/algoritmos/aulas/footnotes/typedef.html
typedef struct
	{
	  int topo ;
	  int tam_MAX;  // vira de uma STRING DADA 
	  char * pt_entradas; // em funcao do tamanho desta
	  // em geral ....  int *pt_entrada;
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

// FALTAM ALGUMAS FUNCOES SEMI-PRONTAS
char * le_entrada_pilha (  tipo_pilha * Pilha ); 
void inicializa_pilha ( tipo_pilha * Pilha);
void carrega_pilha ( char *pt_vetor ,   tipo_pilha * Pilha );

void imprime_pilha ( tipo_pilha * Pilha );

void push (char x, tipo_pilha * P);
void pop (char *x, tipo_pilha * P);
void destroi_pilha ( tipo_pilha * P );

// ESTAS E OUTRAS FUNCOES PODEM IR PARA UM PILHA.H
int pilha_cheia  (tipo_pilha * P);
int pilha_vazia  (tipo_pilha * P);

