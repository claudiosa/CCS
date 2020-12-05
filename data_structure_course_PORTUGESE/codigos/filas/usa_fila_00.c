#include "fila_00.h"

int  main(void)

{   // APLICACAO
	system("clear");
	char vetor[]= "XYZW";
	// entrada caracteres .....
	// TAMANHO LIMITADO ....
	int tamanho = (int) sizeof(vetor) - 1;
	int j;

	/* criar por referencia para nao duplicar os dados.... */
	fila * pt_FILA = cria_fila (  tamanho );

	for ( j = 0 ; vetor[j]!= '\0' ; j ++ )
		{
		// FACA UM SCANF AQUI ....
		chegada ( vetor[j] , pt_FILA );
		// push da vida
		}
		puts("\n FIM das CHEGADAS \n====================================\n");
		//TESTES
		//chegada ( '$' , pt_FILA );
		//chegada ( '#' , pt_FILA );

		while ( fila_vazia  ( pt_FILA) != true )
			{
			printf("\t => %c|%d", partida ( pt_FILA ), tamanho_fila( pt_FILA ) );
			//pop
      }
		puts("\n FIM das PARTIDAS \n====================================");
		//TESTES
		//printf("....\t => %c ", partida ( pt_FILA ));
		//printf("....\t => %c ", partida ( pt_FILA ));

	destroi_fila( pt_FILA ); 
   return 1;
  } /* fim do main */
