#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C
#include <ctype.h> // usado para toupper ... 

// ONDE FORES USAR ESTAS FUNCOES #include "fila_00.h"
 struct STRUCT_FILA
  {
    int  front ;  		/*  ou primeiro ou cabeca da fila */
    int  rear ;	  		/*  ou ultimo ou cauda da fila */
    int  capacidade ; // limite da fila
	//char entradas[ MAX_FILA ];
	int * entrada ;	//INTEIROS
   // apenas um ponteiro para um vetor de int
};
// e ainda
typedef  struct STRUCT_FILA  fila ;

// OS PROTOTIPOS FUNCOES e USO
	fila * cria_fila (  int CAPACIDADE );
	bool  fila_cheia  ( fila * F);
	bool  fila_vazia  ( fila * F);
	int   tamanho_fila ( fila * F );
	void  chegada ( int x, fila * F); // Push ... INT
	int  partida ( fila * F );        // pop .. sai INT
    void  destroi_fila( fila *F);
   void  mostra_fila( fila *F );
 /************************************************/
