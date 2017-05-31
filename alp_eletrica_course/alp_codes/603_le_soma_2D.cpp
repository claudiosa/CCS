#include <stdio.h>
//:~/ccs$ g++ 600_le_escreve_2D.cpp 
//:~/ccs$ ./a.out < entrada_2D.txt

int main (void)
{
  int M, N;  // virah do arquivo texto
  scanf("%d %d", &M, &N);  // lendo
  printf("\nLinhas: %d Colunas: %d \n", M, N);
  
  // apos termos a leitura de  M e N .... 
  // vamos criar e ler a matriz
  int matriz[M][N];
  int i, j; 
  int SOMA = 0;
  float MED_1, MED_2; // SOMA/ (MxN)
  
  /* LEITURA */ 
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
			{ scanf("%d ", & matriz[i][j] );
			 printf (" %d\t", matriz[i][j]);
	       }
			
  /* ESCREVENDO */			
  for (i = 0; i < M; i++)
    {
	 for (j = 0; j < N; j++)
		  printf ("m(%d,%d) = %d\t", i, j, matriz[i][j]);
	  	  printf ("\n");

     } // fim do  2o. for
     
     printf("\n Profs. are humans !!!! \n\n");
		 scanf("%d ", & matriz[i][j] );
			
  /* FAZ SOMA */			
  for (i = 0; i < M; i++)
    {
	 for (j = 0; j < N; j++)
	//	  printf ("m(%d,%d) = %d\t", i, j, matriz[i][j]);
	// 	  printf ("\n");
	  	  SOMA = SOMA + matriz[i][j];

     } // fim do  2o. for
     
    MED_1 = (1.0 * SOMA)/(M*N);//(SOMA*0.1)/(M*N*0.1); 
    MED_2 = ( float ) SOMA/(M*N); 
    printf ("SOMA = %d\t MED_1: %0.4f \t MED_2: %0.4f", SOMA ,MED_1, MED_2);
	printf("\n Profs. are humans !!!! \n\n");

  return 0;
}
