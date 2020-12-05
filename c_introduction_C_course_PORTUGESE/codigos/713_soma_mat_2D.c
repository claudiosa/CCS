#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#define N 5   // 5 colunas
//
// DECLARACAO OU ASSINATURAS DAS FUNCOES
// DECLARADAS ABAIXO OU EM OUTRO ARQUIVO
//
void imp_linha( void )   ;
void func_le_matriz(float mat[][N], int)   ;
void func_escreve_matriz(float mat[][N], int);
void func_soma_matriz(float m1[][N], float m2[][N],
   float m3[][N], int M )   ;
float func_soma_all(float m1[][N], float m2[][N], float m3[][N], int M );

// O detalhe para passar matriz para as funções é que o primeiro par de colchetes
// pode sempre ir vazio -- sem dimensão, e os demais preenchidos ===> func_le_matriz
// E para matriz de 3 dimensoes ?
// funcao MAIN
int main(void)
{
    system("clear");
    int M, K;  // vira do arquivo texto

    printf("\nLinhas -- M :  Colunas -- N ");
    scanf("%d ", &M);  // lendo apenas as linhas
    printf("\nLinhas: %d Colunas: %d \n", M, N);

    // apos a dimensão das matrizes vou criar as variaveis matrizes
    float mat_1[M][N], mat_2[M][N], mat_3[M][N] ;

    func_le_matriz( mat_1, M ); // LEITURA via arquivo
    func_le_matriz( mat_2, M );

    func_escreve_matriz( mat_1, M);// ESCRITAS
    func_escreve_matriz( mat_2, M);

    func_soma_matriz( mat_1, mat_2, mat_3, M); //CALCULOS
    func_escreve_matriz( mat_3, M);  //ESCRITAS

    printf("\n\n A soma de todos elementos das 3 matrizes eh: %f " , func_soma_all (mat_1, mat_2, mat_3, M) ); 

    printf("\n FIM DO MAIN \n" );
   return 1;

  }


/***********************************************************/
  void func_le_matriz(float matriz[][N] , int M )
  { /* LEITURA */
    int i, j;
    for (i = 0; i < M; i++)
      for (j = 0; j < N; j++)
  			scanf("%f ", & matriz[i][j] );
     return;
  }
  /***********************************************************/
  void func_escreve_matriz(float matriz[][N], int M)
  {
    int i, j;
    /* ESCREVENDO */
    imp_linha(); // funcao dentro de outra funcao
    printf ("\n");
    for (i = 0; i < M; i++)
    {
        for (j = 0; j < N; j++)
        {
  		  printf ("\t: %0.2f",  matriz[i][j] );
        }
     printf ("\n"); // pula para proxima linha
    }
    imp_linha();
    return;
  }

  /***********************************************************/
  void imp_linha(void)
    {
    printf("\n====================================");
    return;
    }

    /***********************************************************/
      void func_soma_matriz(float m1[][N], float m2[][N], float m3[][N], int M )
      { /* LEITURA */
        int i, j;
        for (i = 0; i < M; i++)
          for (j = 0; j < N; j++)
      			m3[i][j] = m1[i][j] + m2[i][j];
         return;
      }
      /***********************************************************/
        float func_soma_all(float m1[][N], float m2[][N], float m3[][N], int M )
        { /* LEITURA */
          int i, j;
          float soma = 0; // variavel
          for (i = 0; i < M; i++)
            for (j = 0; j < N; j++)
              soma = soma + (m3[i][j] + m1[i][j] + m2[i][j]);


           return (soma) ;
        }

    /***********************************************************/
