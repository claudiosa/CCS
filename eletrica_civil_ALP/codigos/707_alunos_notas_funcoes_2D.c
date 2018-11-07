#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define N 5

void imp_linha(void);    
void func_le_matriz(float mat_notas[][N], int);
void func_escreve_matriz(float mat_notas[][N], int);
void func_zera_matriz(float mat_notas[][N] , int M );
void func_media_matriz(float mat_notas[][N] , float media[], int M );
float func_maior_nota(float v_media [] , int M) ;
// O detalhe para passar matriz para as funções é que o primeiro par de colchetes
// pode sempre ir vazio -- sem dimensão, e os demais preenchidos ===> func_le_matriz
// E para matriz de 3 dimensoes ?

int main(void)
{
    system("clear");
    int M, K;  // vira do arquivo texto

    printf("\nLinhas -- ALUNOS :  Colunas -- AVALIACOES: ");
    scanf("%d ", &M);  // lendo apenas as linhas
    printf("\nLinhas: %d Colunas: %d \n", M, N);

    // vamos criar e ler a matriz0
    float mat_notas[M][N];
    float v_media[M];
    

    func_le_matriz( mat_notas, M );
    //func_le_matriz( &mat_notas[0][0], M );
   // func_escreve_matriz( mat_notas, M );
    //func_zera_matriz( mat_notas,  M );
    func_media_matriz(mat_notas, v_media, M );
    printf("\n Maior media: %.3f", func_maior_nota(v_media , M) );
    func_escreve_matriz( mat_notas , M );
  //  media_alunoPOND(pesos,notas);
  //  media_classe(notas);
  //  media_finalturma(mediaturmaprova);

  printf("\n FIM DO MAIN \n" );
 return 1;

}
/***********************************************************/
void imp_linha(void)
  {
  printf("\n====================================");
  return;    
  }
/***********************************************************/
void func_le_matriz(float mat_notas[][N] , int M )
{ /* LEITURA */
  int i, j;
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
			scanf("%f ", & mat_notas[i][j] );
   return;
}
/***********************************************************/
void func_zera_matriz(float mat_notas[][N] , int M )
{ /* LEITURA */
  int i, j;
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
			 mat_notas[i][j] =0 ;

   return;
}
/***********************************************************/
void func_media_matriz(float mat_notas[][N] , float v_media[], int M )

{ /* LEITURA */
  int i, j;
  float s_aux;
  for (i = 0; i < M; i++)
   {
     s_aux = 0;
     for (j = 0; j < N; j++) // soma as colunas
     s_aux +=   mat_notas[i][j] ;
   
     v_media[i] = s_aux / N;
    }
   // IMPRIMINDO O VETOR DAS MEDIAS
   for (i = 0; i < M; i++)
   printf("\n Média do aluno %d : %0.2f" , i+1, v_media[i] );
   
   return;
}

/***********************************************************/
float func_maior_nota(float v_media [] , int M) 

{
  float  Maior_Media = v_media [0];
 for(int i=0 ; i < M; i ++)
 {
 if( v_media [i] > Maior_Media  )
   { //printf("\t TROCOU O MAIOR ...\n");
    // printf("\t Maior media ate entao era: %0.2f \n", Maior_Media);
     // printf("\t SERA TROCADA POR: %0.2f \n", v_media [i]);
      Maior_Media = v_media [i];
      //pos_MAIOR = i ;
      }  
  }    
 return Maior_Media; // um float que eh o mesmo tipo da funcao
}
/***********************************************************/
void func_escreve_matriz(float mat_notas[][N] , int M)
{
  int i, j;
  /* ESCREVENDO */
  imp_linha();
  for (i = 0; i < M; i++)
    {
       printf ("\n Notas aluno %d ", i+1);
	     
       for (j = 0; j < N; j++){
		   printf ("\t: %0.2f",  mat_notas[i][j] );
  	  }
  //  printf ("\n");
    }
  imp_linha();
  return;
}

/***********************************************************/