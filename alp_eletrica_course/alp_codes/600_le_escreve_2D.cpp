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

  /* LEITURA */ 
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
			scanf("%d ", & matriz[i][j] );
			
  /* ESCREVENDO */			
  for (i = 0; i < M; i++)
    {
	 for (j = 0; j < N; j++)
		  printf ("m(%d,%d) = %d\t", i, j, matriz[i][j]);
	  	  printf ("\n");

     } // fim do  2o. for
     
     printf("\n Profs. are humans !!!! \n\n");

  return 0;
}
