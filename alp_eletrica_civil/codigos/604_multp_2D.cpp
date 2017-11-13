#include <stdio.h>
// M x N * N x L = M x L
/*
 * m1[M][N] * m2[N][L] = m3[M][L]

 */

int main (void)
{
  int M, N, L;  // virah do arquivo texto
  scanf("%d %d %d", &M, &N, &L);  // lendo
 // printf("\nLinhas: %d Colunas: %d \n", M, N, L);
  
  // apos termos a leitura de  M e N .... 
  // vamos criar e ler a matriz
  int m1[M][N], m2[N][L], m3[M][L];
  
  int i, j, k; 
  int temp = 0;

  
  /* LEITURAS */ 
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
			 scanf("%d ", & m1[i][j] );
			 
  for (i = 0; i < N; i++)
    for (j = 0; j < L; j++)
			 scanf("%d ", & m2[i][j] );			 
			
			
  /* FAZ MULTIPLICA MATRIZES */			
  for (i = 0; i < M; i++)
    {
	 for (j = 0; j < L; j++)
	   { 
		temp = 0; // a cada nova coluna reinicie o acumulador   
	    for (k = 0; k < N; k++)
	       { temp =  m1[i][k]*m2[k][j] + temp; 
		   }
	       m3[i][j]= temp; 
	    } 
     } // fim do  for i
     
         
  printf("\n SAIDA \n");      
  for (i = 0; i < M; i++)
  { printf("\n |  " );
    for (j = 0; j < L; j++)
		 printf("%d  ",  m3[i][j] );
	printf("|" );	 
   }  
    
	printf("\n Profs. are humans !!!! \n\n");

  return 0;
}
