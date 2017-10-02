
// Definicao de lista_11.h
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C

// DEFINICAO DO NO de lista
struct NO_struct
  {
    //char nome[N]; // aqui uma outra struct
    char *pt_nome;
    struct NO_struct *next; 
  };

typedef struct NO_struct  noh_tipo;

noh_tipo * cria_no(void);
void imp_lista(noh_tipo *L);
int  ins_fim_lista  (char *pt_ENTRADA, noh_tipo **L);
void ins_inic_lista (char *pt_ENTRADA, noh_tipo **L);
void ins_fim_lista_2(char *pt_ENTRADA, noh_tipo **L);
void destroi_lista( noh_tipo **L );

/****************************************/