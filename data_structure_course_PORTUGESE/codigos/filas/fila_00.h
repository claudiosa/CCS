#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C

// ONDE FORES USAR ESTAS FUNCOES #include "fila_00.h"
 struct STRUCT_FILA
  {
    int  front ;  		/*  ou primeiro ou cabeca da fila */
    int  rear ;	  		/*  ou ultimo ou cauda da fila */
    int  capacidade ; // limite da fila
	//char entradas[ MAX_FILA ];
	 char * entrada ;	// VOCE e seus INTEIROS
   // apenas um ponteiro para uma STRING
};
// e ainda
typedef  struct STRUCT_FILA  fila ;

// OS PROTOTIPOS FUNCOES e USO
	fila * cria_fila (  int CAPACIDADE );
	bool  fila_cheia  ( fila * F);
	bool  fila_vazia  ( fila * F);
	int   tamanho_fila ( fila * F );
	void  chegada ( char x, fila * F); // Push ... char
	char  partida ( fila * F );        // pop .. sai char
  void  destroi_fila( fila *F);
  void  mostra_fila( fila *F );
    /************************************************/
