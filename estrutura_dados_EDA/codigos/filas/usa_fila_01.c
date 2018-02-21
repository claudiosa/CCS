#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C
#include "fila_00.h"

 int  main(void)

{   // APLICACAO
	system("clear");
	int Capacidade = 3, i = 0;
	char UM_CHAR; // entrada
    //printf("\n Qual tamanho da entrada na fila: ");
    //scanf("%d", &Capacidade );
    printf("\n Leitura Capacidade: %d ", Capacidade );

	/* criar por referencia para nao duplicar os dados.... */
	fila * pt_FILA = cria_fila (  Capacidade );
	printf("\n Quantos na fila: %d ", tamanho_fila(pt_FILA) );
    fflush(stdin);
	// while ( fila_cheia ( pt_FILA) != true )		
	while( i <= Capacidade )
		{	
		//	printf("\n Chegando : "); 
		//	scanf("%c%*c", &UM_CHAR);
        //	UM_CHAR = getchar();
		UM_CHAR =  'A' + i;	// adicionando um caracter 
        chegada ( UM_CHAR , pt_FILA );
		// printf("\n Quantos na fila: %d || lido: %c", tamanho_fila(pt_FILA), UM_CHAR);

		i++;
		}
	
		// printf("\n Quantos na fila: %d || lido: %c", tamanho_fila(pt_FILA), UM_CHAR);
		mostra_fila(pt_FILA);
		puts("\n FIM das CHEGADAS \n====================================\n");
		//TESTES
		//chegada ( '$' , pt_FILA );	
		//chegada ( '#' , pt_FILA );	

	while ( fila_vazia  ( pt_FILA) != true )
	 	{
		printf("\t => %c|%d", partida ( pt_FILA ), tamanho_fila( pt_FILA ) );
        }
		puts("\n FIM das PARTIDAS \n====================================");
		//TESTES
		//printf("....\t => %c ", partida ( pt_FILA ));
		//printf("....\t => %c ", partida ( pt_FILA ));	

   destroi_fila( pt_FILA ); 
   return 1;			
  } /* fim do main */
