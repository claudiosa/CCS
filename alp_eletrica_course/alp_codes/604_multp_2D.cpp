#include <stdio.h>
// M x N * N x L = M x L
/*
 * m1[M][N] * m2[N][L] = m3[M][L]
 *  
 * 
 */

int main (void)
{
  int M, N, L;  // virah do arquivo texto
  scanf("%d %d %d", &M, &N, &L);  // lendo
  printf("\nLinhas: %d Colunas: %d \n", M, N, L);
  
  // apos termos a leitura de  M e N .... 
  // vamos criar e ler a matriz
  int m1[M][N], m2[N][L], m3[M][L];
 
 
  int i, j; 
  int temp = 0;
  float MED_1, MED_2; // SOMA/ (MxN)
  
  /* LEITURA */ 
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
			 scanf("%d ", & matriz[i][j] );
			
  /* FAZ SOMA */			
  for (i = 0; i < M; i++)
    {
	 for (j = 0; j < N; j++)
	   {
	    for (k = 0; k < l; k++)
	        temp =  m1[i][j]*m2[j][k] + temp;
	      
	        m3[i][k]= temp; 

FALTANDO ....

     } // fim do  2o. for
     
    
    
    
    
    printf ("SOMA = %d\t MED_1: %0.4f \t MED_2: %0.4f", SOMA ,MED_1, MED_2);
	printf("\n Profs. are humans !!!! \n\n");

  return 0;
}
