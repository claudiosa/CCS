#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

long int  func_fat( int ) ; // DECLARAR A FUNCAO
// MOSTRAR QUE AS FUNCOES SAO VISIVEIS NESTE ARQUIVO
void preenche_vetor_fat(long int v[] , int  ) ;
// A ASSINATURA DA FUNCAO ... olhe v[] ... nao vai indice ou tamanho

int main(void) {

int i, n;

printf("\n Quantos N voce quer? " );
scanf("%d" , &n);

long int vetor [n]; // criamos o vetor de tamanho n
// apos n ser lido ... senao erro pois n esta indefinido
preenche_vetor_fat(  & vetor[0] , n ); // chama esta FUNCAO eh VOID
printf("\n Acabou de fazer o preenchimento  do vetor" );

for (i = 0; i < n; i++) // imprimir vetor
{
  printf("\n vetor[ %d]: %ld ", i, vetor[i] );
}
printf("\n Acabou o main !!! \n " );
return 1; // fim

} // FIM DO MAIN
/////////////////////////////////////////////////////////////////
void preenche_vetor_fat(long int v[] , int tam )
{
  int x;
  printf("\n ==> Em preenche_vetor_fat \n" );
  for (x = 0; x < tam; x++)
  {
    v[x] = func_fat( x );// 1, 2, 3, ... n argumento 1 por vez
    printf("\n %d tem o valor do fatorial igual: %ld", x, v[x] );
  }
printf("\n ACABOU O preenchimento do VETOR fatorial \n" );
return ; // POIS EH VOID NA FUNCAO
} // FIM DA FUNCAO: preenche_vetor_fat

///////////////////////////////////////////////////////////////// ULTIMA AULA esta funcao

long int func_fat ( int n )
{
  long int Resp_fat;
  Resp_fat = 1;
  printf("\n" );
  for ( ; n >= 1; n-- )
  {
     Resp_fat =  n * Resp_fat;
     printf("* ");
  };
   printf("\n retorno na função FATORIAL simples" );
  return(Resp_fat)  ;
}
///////////////////////////////////////////////////////////////// 
