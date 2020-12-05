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
  int matriz[M][N]; // M x N
  int transp_01[N][M]; // N x M  
  int transp_02[N][M]; // N x M  
  
  
  int i, j; 

  /* LEITURA */ 
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
	scanf("%d ", & matriz[i][j] );
			
 /* IMPRIMINDO transp_01 por matriz e copiando as matrizes	
    ORIGINAL para transp_01 */

   printf ("\n\n MATRIZ ORIGINAL \n");
   for (i = 0; i < M; i++)
    {
     for (j = 0; j < N; j++)
       {
        // nao esquecer 
       	transp_01[i][j] = matriz[i][j]; // ATRIBUIR ANTES DE IMPRIMIR
        transp_02[j][i] = matriz[i][j]; // ATRIBUIR ANTES DE IMPRIMIR
 	printf ("t(%d,%d) = %d | ", i, j, matriz[i][j] );
       }
	   printf ("\n");
     } // fim do  2o. for

   printf ("\n IMPRIMINDO PELA transp_01 \n");
  /* IMPRIMINDO PELA transp_01 */			
  for (j = 0; j < N; j++) // em J ... por linha
    {
     for (i = 0; i < M; i++)
       printf("t(%d,%d) = %d  ", i, j, transp_01[i][j]);
	  
    printf("\n");// do for externo
    } // fim do  2o. for
     
       
   printf ("\n\n IMPRIMINDO PELA transp_02 \n");
  /* IMPRIMINDO PELA transp_02 */			
  for (j = 0; j < N; j++) // em J ... por linha
    {
     for (i = 0; i < M; i++)
      printf("t(%d,%d) = %d  ", j, i, transp_02[j][i]);
       printf("\n");
    } // fim do  2o. for
     
  printf("\n Profs. are humans !!!! \n\n");

  return 0;
}
