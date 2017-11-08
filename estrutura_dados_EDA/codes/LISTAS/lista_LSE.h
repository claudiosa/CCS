
// Definicao de lista_11.h
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C

// DEFINICAO DO NO de lista
struct NO_struct
  {
    //char nome[N]; //ou uma outra struct
    char *pt_nome; // para prova simplesmente int conteudo;
    struct NO_struct *next; 
  };

typedef struct NO_struct  NOH_tipo_LSE;

NOH_tipo_LSE * cria_no(void);
void imp_lista(NOH_tipo_LSE *L);
int  ins_fim_lista  (char *pt_ENTRADA, NOH_tipo_LSE **L);
void ins_inic_lista (char *pt_ENTRADA, NOH_tipo_LSE **L);
void ins_fim_lista_2(char *pt_ENTRADA, NOH_tipo_LSE **L);
void destroi_lista( NOH_tipo_LSE **L );
int comprimento_lista( NOH_tipo_LSE **L );
bool exclui_n_esimo_lista( int n, NOH_tipo_LSE **L );
bool inclui_n_esima_lista( int n, char *pt_DADO, NOH_tipo_LSE **L );
bool exclui_o_ultimo_lista(  NOH_tipo_LSE **header_L );
bool esta_vazia( NOH_tipo_LSE **L );
int recurs_comp_lista_1( NOH_tipo_LSE *L );
int recurs_comp_lista_2( NOH_tipo_LSE **L );
/****************************************/