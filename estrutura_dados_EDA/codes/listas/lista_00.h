#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C
#include <stdio_ext.h> // limpeza de BUFFER
#define N 33

// DEFINICAO DO NO de lista
struct NO_struct
  {
    char nome[N]; // aqui uma outra struct
    struct NO_struct *next; 
  };

typedef struct NO_struct  noh_tipo;


noh_tipo * cria_no(void);
void ins_lista(char x_nome[], noh_tipo *L);
void insere_lista(char x_nome[], noh_tipo *L);
//int is_empty( noh_tipo *L );
void imp_lista(noh_tipo *L);
