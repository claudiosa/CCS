#include <stdio.h>
#include <stdlib.h>
#include <math.h>
// g++
// ./a.out < entradaSIGA.txt
    int N=2;
    int K=2;

void funcao_le_matriz(float matriz[][K],float,float);
void funcao_escreve_matriz(float matriz[][K], float, float);
void mediaaluno_POND(float *pesos,float matriz[N][K]);
void media_classe();
    float mediaturmaprova[2],mediapond[9]={0,0,0,0,0,0,0,0,0,0}, notas[2];
    float pesos[2]={0.2,0.6,0.2};


int main(void)
{
     /*
    int N, K;  // vira do arquivo texto
    scanf("%d %d", &M, &Colunas);  // lendo
    printf("\nLinhas: %d Colunas: %d \n", M, Colunas);
    */

    // vamos criar e ler a matriz0
    float matriz[N][K];
    funcao_le_matriz( matriz, N,  K);
    funcao_escreve_matriz( matriz, N,  K);
    media_alunoPOND(pesos,notas);
    media_classe(notas);
    media_finalturma(mediaturmaprova);


}
void funcao_le_matriz(float matriz[][K], float  N, float K)
{
    /* LEITURA */
  int i, j;
  for (i = 0; i < N; i++)
    for (j = 0; j < K; j++)
			scanf("%f ", & matriz[i][j] );
   return;
}
void funcao_escreve_matriz(float matriz[][K], float N, float K)
{
  /* LEITURA */
  int i, j;
  /* ESCREVENDO */
  for (i = 0; i < N; i++)
    {
	 for (j = 0; j < K; j++){
		  printf ("Nota aluno %d na prova %d = %f\t", i+1, j+1, matriz[i][j]);
	  	  printf ("\n");
        }
    }
}
void media_alunoPOND(float *pesos[2],float *matriz[N][K]) //média ponderada do aluno por prova
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
void media_classe(float *notas) //média aritmetica da classe por prova
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

