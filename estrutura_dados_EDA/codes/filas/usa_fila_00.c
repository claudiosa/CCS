#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C

 struct STRUCT_FILA
  {
    int  front ;  		/*  or first */
    int  rear ;	  		/*  or last */
    int  capacidade ; 		 	
	 //char entradas[ MAX_FILA ];
	 char * entrada ;	
};
// e ainda
typedef  struct STRUCT_FILA  fila ;

	//typedef int MY_boolean;
	bool  fila_cheia  ( fila * F);
	bool  fila_vazia  ( fila * F);
	int tamanho_fila ( fila * F );
	fila * cria_fila (  int C );
	void chegada ( char x, fila * F); // entra ... char
	char  partida ( fila * F ); // diferente .. sai char
    void exclui_fila( fila *F);

int  main(void)

{   // APLICACAO
	system("clear");
	char vetor[]= "XYZW";
	int tamanho = (int)sizeof(vetor) - 1;
	int j;

	/* criar por referencia para nao duplicar os dados.... */
	fila * pt_FILA = cria_fila (  tamanho );

			
		for ( j = 0 ; vetor[j]!= '\0' ; j ++ ) 
			{	
			chegada ( vetor[j] , pt_FILA );
		    }

		puts("\n FIM das CHEGADAS \n====================================\n");
			

		while ( fila_vazia  ( pt_FILA) != true )
			{
				printf("....\t => %c ", partida ( pt_FILA ));
            }
		puts("\n FIM das PARTIDAS \n====================================");
			

	exclui_fila( pt_FILA ); 
   return 1;			
  } /* fim do main */
