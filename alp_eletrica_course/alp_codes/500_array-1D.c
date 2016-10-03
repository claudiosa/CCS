
// Imprimindo o conteudo de um vetor.....
#include <stdio.h>
int main(){
   //  int vetor[10] = {3, 4, 5, 5 ,6, 7, 8, 9, -9, -8};
     int vetor[] = {3, 4, 5, 5 ,6, 7, 8, 9, -9, -8};
     // ALOCOU UM Vetor com 10 posicoes
     int i,n;
     n = (float) (sizeof(vetor) / sizeof(int));//coerse ... coerção   
     // forçando que a divisão ocorra como fosse para
     // reais
     printf("\n NUM de Bytes dos inteiros: %zu # %d", sizeof(int), sizeof(int));  
     printf("\n Tamanho do vetor: %zu", sizeof(vetor));
     printf("\n Numero de elementos  do vetor: %d\n\n", n);
     for(i=0; i < n ;  i++ ){
     // {3, 4, 5, 5 ,6, 7, 8, 9, -9, -8}; 
     printf("\n vetor[%d]: %d", i,  vetor[i]);
     }
     printf("\n ERRO COMUM 1: vetor[%d]: %d ", i,  vetor[i]);
     printf("\n ERRO COMUM 2: vetor[%d]: %d\n", (i+1),  vetor[(i+1)]);

return 0;
}
