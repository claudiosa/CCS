#include<stdio.h>
#include <stdlib.h>
#include <math.h> 

#define N 8
// a ultima dimensao deve ser declarada
void inicializa_matriz( int  matriz[][N] , int );
void imprime_matriz( int matriz[N][N] , int );
int ataques_rainha( 
	  int x_queen, int y_queen,
	  int x_king, int y_king
	  );
  
int main(void)
{
   /* leitura **/
//  int N; // DIMENSAO TABULEIRO
  int x_Rainha, y_Rainha;
  int x_REI, y_REI;
   
   /* 5 variáveis */
//   scanf("%d", &N);
   printf("\nDigite as POSICOES da Rainha e depois do REI ... 0 e 7\n ==>");
   //scanf("%d %d", &x_Rainha, &y_Rainha);
   //scanf("%d %d", &x_REI, &y_REI);
/***************************************************/

   x_Rainha = 3;
   y_Rainha = 3;

   x_REI = 6;
   y_REI = 6;


   int matriz[N][N];

   inicializa_matriz( matriz ,  N);
   printf("\n----------------------------------\n");
   matriz[x_Rainha][y_Rainha] = 1;
   matriz[x_REI][y_REI] = 2;
   
   imprime_matriz( matriz ,  N);
   int resposta =  ataques_rainha( 
	  x_Rainha, y_Rainha,
	  x_REI, y_REI );

   printf("\n----------------------------------\n");
   //imprime_matriz( matriz ,  N);
   
   if ( resposta == 0 )
      printf(" \n POSICAO OK DO REI ");
      else
      printf(" \n POSICAO de PERIGO  AO REI ");
   
   printf("\n----------------------------------\n");

   imprime_matriz( matriz ,  N);
     // 1a funcao de inicializa a matriz ... encher de 0
    // 2a funcao de  imprimir a matriz ... ver se estah OK
    // 3a funcao recebe i,j da Rainha ... e preencher com 1 as diagonais e H e V
    // 4a funcao recebe i,j do Rei ... e verifcar se i,j esta nas celulas com 1 as diagonais e H e V  

    printf("\n----------------------------------");
    printf("\n RAINHA: [%d , %d]", x_Rainha, y_Rainha);
    printf("\n REI: [%d , %d]\n", x_REI, y_REI);

    return 1;  // FIM DO MAIN
    
}


/*******************************************************************/
void inicializa_matriz( int matriz[][N], int TAM)
{
  int i, j; 	
  /* INICIALIZA COM 0 TODA MATRIZ */ 
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
 		  printf (" %d",  matriz[i][j]);
//		  printf ("[%d,%d]:%d\t", i, j, matriz[i][j]);
	  	  printf ("\n");
     } // fim do  2o. for
   
   return;
 }  
/*******************************************************************/
int ataques_rainha( int x_queen, int y_queen,
	                int x_king, int y_king)
{
    int chave = 0;
    // ESTAO SOB A DIAGONAL  
    if(abs(x_queen - x_king) == abs(y_queen - y_king ))
    chave++;
    
    if (abs(x_queen-x_king) == 0)   
    chave++;

    if (abs(y_queen-y_king) == 0)   
    chave++;
    
    return chave;
 }  
