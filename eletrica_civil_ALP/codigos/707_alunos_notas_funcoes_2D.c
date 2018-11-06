#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*
void mediaaluno_POND(float *pesos,float matriz[N][K]);
void media_classe();
    float mediaturmaprova[2],
          mediapond[9]={0,0,0,0,0,0,0,0,0,0},
          notas[2];
    float pesos[2]={0.2, 0.6, 0.2};
*/
#define N 5
void funcao_le_matriz(float matriz[][N], int);
void funcao_escreve_matriz(float matriz[][N], int);
void funcao_zera_matriz(float matriz[][N] , int M );
// o detalhe para passar matriz para as funções é que o primeiro par de colchetes
// pode sempre ir vazio -- sem dimensão, e os demais preenchidos ===> funcao_le_matriz


int main(void)
{

    int M, K;  // vira do arquivo texto
    printf("\nLinhas -- ALUNOS :  Colunas -- AVALIACOES: ");
    scanf("%d ", &M);  // lendo
    printf("\nLinhas: %d Colunas: %d \n", M, N);

    // vamos criar e ler a matriz0
    float matriz[M][N];
    funcao_le_matriz( matriz, M );
    //funcao_le_matriz( &matriz[0][0], M );
    funcao_escreve_matriz( matriz, M );
    funcao_zera_matriz( matriz ,  M );
    funcao_escreve_matriz( matriz, M );
  //  media_alunoPOND(pesos,notas);
  //  media_classe(notas);
  //  media_finalturma(mediaturmaprova);

  printf("\n FIM DO MAIN \n" );
 return 1;

}

void funcao_le_matriz(float matriz[][N] , int M )
{ /* LEITURA */
  int i, j;
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
			scanf("%f ", & matriz[i][j] );
   return;
}

void funcao_zera_matriz(float matriz[][N] , int M )
{ /* LEITURA */
  int i, j;
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++)
			 matriz[i][j] =0 ;
   return;
}
/***********************************************************/



/***********************************************************/
void funcao_escreve_matriz(float matriz[][N] , int M)
{
  int i, j;
  /* ESCREVENDO */
  for (i = 0; i < M; i++)
    {
      printf ("\n Notas aluno %d ", i+1);
	     for (j = 0; j < N; j++){
		  printf ("\t: %0.2f",  matriz[i][j] );
  	  }
  //  printf ("\n");
    }

   return;
}

/*


void media_alunoPOND(float *pesos[2],float *matriz[N][K]) //m�dia ponderada do aluno por prova
{

    printf("\n ========Media ponderada dos alunos nas provas =========\n");
    for(int i=0;i<N;i++)
    {
        for(int j=0;j<K;j++)
        {
            mediapond[i]+= matriz[i][j]*pesos[j];
        }
        printf("Media aluno %d: %f\n",i+1,mediapond[i]);
    }
}
void media_classe(float *notas) //m�dia aritmetica da classe por prova
{
    float somaturmaprova[2]={0,0,0};
    printf("\n ========Media aritmetica da turma por prova =========\n");
    for(int i=0;i<N;i++)
    {
        for(int t=0;t<K;t++)
        {

        somaturmaprova[t] += notas[t];

        }
    }
    for(int i=0;i<K;i++)
    {
        mediaturmaprova[i]= somaturmaprova[i]/N;
        printf("A media da turma na prova %d: %f\n",i+1,mediaturmaprova[i]);
    }
}

void media_finalturma(float *mediaturmaprova)
{
    float somafinalturma, mediafinalturma;
    printf("\n ==========Media final da turma ==========\n");
    for(int i=0;i<K;i++)
    {
        somafinalturma += mediaturmaprova[i];
    }
    mediafinalturma = somafinalturma/10;
    printf("\nA media final da turma e : %f\n", mediafinalturma);

}
*/
