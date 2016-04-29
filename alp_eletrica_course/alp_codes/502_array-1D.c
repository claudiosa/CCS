// Entrada via ARQUIVO
/*
 * $ ./a.out <  entrada_array_1d.txt
 * 
 */ 
#include <stdio.h>
int main(){
	 int tamanho;
	 scanf("%d", &tamanho);
	  
     int vetor[tamanho];
    // LEITURA DO VETOR 
    for(int i=0; i < tamanho ; i++ ){
	   scanf("%d", &vetor[i]);
	   }
    // ESCRITA  DO VETOR 
    for(int i=0; i < tamanho ; i++){
      printf("\n vetor[%d]: %d", i,  vetor[i]);
      }
     
return 0;
}
