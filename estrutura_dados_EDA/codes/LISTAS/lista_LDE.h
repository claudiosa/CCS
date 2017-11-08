
// Definicao de lista_11.h
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C

// DEFINICAO DO NO de lista
struct NO_struct_LDE
  {
    //char nome[N]; // aqui uma outra struct
    char *pt_nome;
    struct NO_struct_LDE *next; 
    struct NO_struct_LDE *prev; // previous = anterior 
  };

typedef struct NO_struct_LDE  NOH_tipo_LDE;

/**
FIZ APENAS OS METODOS DOS SLIDES
**/

NOH_tipo_LDE * cria_no(void);
void imp_lista(NOH_tipo_LDE *L);
void insere_fim_lista_2  (char *pt_ENTRADA, NOH_tipo_LDE **L);
void insere_inicio_lista (char *pt_ENTRADA, NOH_tipo_LDE **L);
void destroi_lista( NOH_tipo_LDE **L );
int  comprimento_lista( NOH_tipo_LDE **L );

/*
METODOS ... 

int  ins_fim_lista  (char *pt_ENTRADA, NOH_tipo_LDE **L);
bool exclui_n_esimo_lista( int n, NOH_tipo_LDE **L );
bool inclui_n_esima_lista( int n, char *pt_DADO, NOH_tipo_LDE **L );
bool exclui_o_ultimo_lista(  NOH_tipo_LDE **header_L );
*/
/****************************************/