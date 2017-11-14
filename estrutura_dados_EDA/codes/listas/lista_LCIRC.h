
// Definicao de lista_11.h
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C

// DEFINICAO DO NO de lista
struct NO_struct_LCIRC
  {
    //char nome[N]; // aqui uma outra struct
    char *pt_nome;
    struct NO_struct_LCIRC *next; 
   
  };

typedef struct NO_struct_LCIRC  NOH_tipo_LCIRC;

/**
APENAS ALGUNS METODOS DOS SLIDES ..... testados
**/

NOH_tipo_LCIRC * cria_no(void);
void imp_lista(NOH_tipo_LCIRC *L);
int  insere_final_lista  (char *pt_ENTRADA, NOH_tipo_LCIRC **L);
int  insere_inicio_lista (char *pt_ENTRADA, NOH_tipo_LCIRC **L);
void destroi_lista( NOH_tipo_LCIRC **L );
int  comprimento_lista( NOH_tipo_LCIRC **L );
bool exclui_n_esimo_lista( int n, NOH_tipo_LCIRC **L );

/*
FALTAM METODOS ... 
int  ins_fim_lista  (char *pt_ENTRADA, NOH_tipo_LCIRC **L);
bool inclui_n_esima_lista( int n, char *pt_DADO, NOH_tipo_LCIRC **L );
bool exclui_o_ultimo_lista(  NOH_tipo_LCIRC **header_L );
*/
/****************************************/