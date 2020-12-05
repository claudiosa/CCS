#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
// ASSINATURAS das FUNCOES
long int  func_fat( int ) ; // DECLARA A FUNCAO
// MOSTRAR QUE AS FUNCOES SAO VISIVEIS NESTE ARQUIVO
void preenche_vetor_fat(long int v[] , int ) ;
// A ASSINATURA DA FUNCAO ... olhe v[] ... nao vai indice ou tamanho
void soma_2_vetores(int v_1[], int v_2[], int v_3[], int);

int main(void) {

int i; // INDEx
int vetor_1 [] = {1, 3, 5, 7}; // criamos o vetor de tamanho n
int vetor_2 [] = {10, 30, 50, 70}; // criamos o vetor de tamanho n
int tam = sizeof(vetor_1) / sizeof(int);
printf(" Tamanho do vetor %ld\n", sizeof(vetor_1) );
printf(" Tamanho do inteiro %ld\n", sizeof(int) );
int vetor_3[tam];

// Chamar a funcao
//soma_2_vetores(vetor_1, vetor_2, vetor_3, tam); // OU
soma_2_vetores(&vetor_1[0], &vetor_2[0], &vetor_3[0], tam);

for (i = 0; i < tam; i++) // imprimir vetor
{
// printf("\n vetor[%d]: %ld\t End_X: %x\t End_octal: %o", i, vetor_3[i],  &vetor_3[i], &vetor_3[i]);
printf("%d + %d = %d\n", vetor_1[i], vetor_2[i], vetor_3[i]);
}

printf("\n Acabou o main !!! \n " );
return 1; // fim

} // FIM DO MAIN
/////////////////////////////////////////////////////////////////
void soma_2_vetores(int v_1[], int v_2[], int v_3[], int tamanho )
{ int i; // declarado NOVO i ... nao eh o do main
for (i = 0; i < tamanho; i++) // imprimir vetor
{
 v_3[i] =  v_1[i] +  v_2[i];
}
return;
}

/////////////////////////////////////////////////////////////////

void preenche_vetor_fat(long int v[] , int tam )
{
  int x;
  printf("\n ==> Em preenche_vetor_fat \n" );
  for (x = 0; x < tam; x++)
  {
    v[x] = func_fat( x );//0, 1, 2, 3, ... n argumento 1 por vez
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
     printf("*");
  };
  // printf("\n retorno na função FATORIAL simples" );
  return(Resp_fat)  ;
}
/////////////////////////////////////////////////////////////////
