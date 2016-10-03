
// SOMA DO CONTEUDO DE UM VETOR
#include <stdio.h>
int main(){
     int vetor[10] = {3, 4, 5, 5 ,6, 7, 8, 9, -9, -8};
     // criando um vetor com 10 posicoes
     int i, n, soma=0;
     n = (float) (sizeof(vetor) / sizeof(int));//coerse ... coerção   
     // forçando que a divisão ocorra como fosse para
     // reais
     printf("\n NUM de Bytes dos inteiros: %zu", sizeof(int));  
     printf("\n Tamanho do vetor: %zu", sizeof(vetor));
     printf("\n Numero de elementos  do vetor: %d\n\n", n);
     for(i=0; i < n ;  i++ ){
     // {3, 4, 5, 5 ,6, 7, 8, 9, -9, -8}; 
     soma = soma +  vetor[i];
     }
     printf("\n Soma FINAL: %d", soma);
     printf("\n Valor Medio: %0.3f\n", (float)soma/n);
 return 0;
}
