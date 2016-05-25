#include<stdio.h>
#include <stdlib.h>

#define N 8
// a ultima dimensao deve ser declarada
void zera_matriz(   int  matriz[][N] , int );
void imprime_matriz( int matriz[N][N] , int );
void ataques_rainha(   int  matriz[][N] , int , int, int);
  
int main()
{
   int matriz[N][N];
   
   zera_matriz( matriz ,  N);
  // imprime_matriz( matriz ,  N);
   ataques_rainha( matriz , N , 3, 4);
   printf("\n----------------------------------\n");
   imprime_matriz( matriz ,  N);
   // 3a linha 4a. coluna
    // 1a funcao de inicializa a matriz ... encher de 0
    // 2a funcao de  imprimir a matriz ... ver se estah OK
    // 3a funcao recebe i,j da Rainha ... e preencher com 1 as diagonais e H e V
    // 4a funcao recebe i,j do Rei ... e verifcar se i,j esta nas celulas com 1 as diagonais e H e V  
      
    
  return 1;  
}
/*******************************************************************/
void zera_matriz( int matriz[][N], int TAM)
{
  int i, j; 	
  /* inicializa com 0 toda matriz */ 
  for (i = 0; i < TAM; i++)
    for (j = 0; j < TAM; j++)
			 matriz[i][j] = 0;
   return;
 }  
 
/*******************************************************************/
void imprime_matriz( int matriz[][N], int TAM)
{/* IMPRIME toda matriz */ 
 int i, j; 
 for (i = 0; i < TAM; i++)
    {
	 for (j = 0; j < TAM; j++)
		 // printf ("m(%d,%d) = %d\t", i, j, matriz[i][j]);
		  printf ("[%d,%d]:%d\t", i, j, matriz[i][j]);
	  	  printf ("\n");
     } // fim do  2o. for
   
   return;
 }  
/*******************************************************************/
void ataques_rainha(int  matriz[][N], int TAM, int row, int col)
{/* IMPRIME toda matriz */ 
 int i, j; 
 for (j = 0; j < TAM; j++)
    matriz[row][j] = 1;
 
 for (i = 0; i < TAM; i++)
    matriz[i][col] = 1;

// SOLUCAO ROGERIO ....
 
 // Na diagonal esquerda -> acima
 for (i = row, j=col ; i>=0 && j >=0 ; j--, i--)
  matriz[i][j] = 1;

 // Na diagonal esquerda -> baixo
 for (i = row, j=col ; i< N && j >=0 ; j--, i++)
  matriz[i][j] = 1;
  
 // Na diagonal  direita -> acima
 for (i = row, j=col ; i>=0 && j < N ; j++, i--)
  matriz[i][j] = 1;

 // Na diagonal  direita -> baixo
 for (i = row, j=col ; i<N && j<N ; j++, i++)
  matriz[i][j] = 1;

  
 //PARA ESTUDO ...
    
//  matriz[i-abs(i-row)][abs(j-col)] = 1;
   
  
  // for (j = 0; j < TAM; j++)
   //  matriz[abs(i-row)][j] = 1;
  
 
   return;
 }  
