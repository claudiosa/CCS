#include <stdio.h>
#include <stdlib.h>
//:~/ccs$ g++ ............... 
//./a.out < entrada_5x5.txt
#define M 5
#define N 5

void funcao_le_matriz(int matriz[][N], int , int );
void funcao_escreve_matriz(int matriz[][N] , int , int );

/* *******************************************************************/
int main (void)
{
  /*
  int M, N;  // virah do arquivo texto
  scanf("%d %d", &M, &Colunas);  // lendo
  printf("\nLinhas: %d Colunas: %d \n", M, Colunas);
  */
   
  
  // vamos criar e ler a matriz0
  int matriz[M][N];
  
  funcao_le_matriz( matriz, M,  N);
  funcao_escreve_matriz( matriz, M,  N);
  printf("\n Profs. are humans !!!! \n\n");
  return 0;
}
/********************************************************************/
void funcao_le_matriz(int matriz[][N], int Linhas, int Colunas)
{
  /* LEITURA */ 
  int i, j;
  for (i = 0; i < Linhas; i++)
    for (j = 0; j < Colunas; j++)
			scanf("%d ", & matriz[i][j] );
   return;
}			
/********************************************************************/
void funcao_escreve_matriz(int matriz[][N], int Linhas, int Colunas)
{
  /* LEITURA */ 
  int i, j;
  /* ESCREVENDO */			
  for (i = 0; i < Linhas; i++)
    {
	 for (j = 0; j < Colunas; j++)
		  printf ("m(%d,%d) = %d\t", i, j, matriz[i][j]);
	  	  printf ("\n");

     } // fim do  2o. for
        return;
} 
/********************************************************************/
