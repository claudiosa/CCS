#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1000

int main(void)
{
  int r, i, temp;
  int chaves[N];
 for(i=0;i<N;i++)
 {
 	chaves[i] = i;
 }
  
  srand((unsigned) time(NULL));// nova semente ...
// EMBARALHANDO
 char letra; 
 for(i=0;i<N;i++)
 {
  //chaves[i] = rand() % N;
  r = rand() % N;	
  temp = chaves[i];
  chaves[i] = chaves[r];
  chaves[r]  = temp;

  //printf("%d ",r);
 }

//imprimindo com letras embaralhadas ...
 for(i=0;i<N;i++)
 {
 letra = (char) (97 + (rand() % (122 - 96)))  ;	
 printf("%d  %c  %.2f\n", chaves[i], letra, chaves[i]*0.1 );	
 }

/* 97 = a ao z 122 */

//Para gerarvalores inteiros aleatórios em C no intervalo [a, b):
//a + rand() % (b - a)

 return(0);
}

