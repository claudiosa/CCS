
// Imprimindo o conteudo de um vetor.....
#include <stdio.h>
int main(){
     int vetor[10] = {3, 4, 5, 5 ,6, 7, 8, 9, -9, -8};
     // criei o vetor com 10 posicoes
     int i,n,soma=0;
     n = (float) (sizeof(vetor) / sizeof(int));//coerse ... coerção   
     // forçando que a divisão ocorra como fosse para
     // reais
     printf("\n Bytes de inteiros %zu", sizeof(int));  
     printf("\n Tamanho do vetor %zu", sizeof(vetor));
     printf("\n Numero de elmentos  do vetor %d\n\n", n);
     for(i=0; i < n ;  i++ ){
     // {3, 4, 5, 5 ,6, 7, 8, 9, -9, -8}; 
     printf("\n vetor[%d]: %d", i,  vetor[i]);
     }
     printf("\n\n ERRO COMUM: vetor[%d]: %d\n", i,  vetor[i]);
return 0;
}
