// Entrada via ARQUIVO
/*
 * $ ./a.out <  entrada_array_1d.txt
   MUITO UTIL ESTE EXEMPLO 
 */ 
#include <stdio.h>
int main(){
	 int tamanho;
	 scanf("%d", &tamanho);
	  
     int vetor[tamanho];
    // LEITURA DO VETOR 
    for(int i=0; i < tamanho ; i++ ){
	   scanf("%d ", &vetor[i]);
	   }
    // ESCRITA  DO VETOR 
    for(int i=0; i < tamanho ; i++){
      printf("\t vetor[%d]: %d", i,  vetor[i]);
      }
     
 // ESCRITA  ORDEM INVERSA VETOR 
    for(int i=(tamanho-1); i >= 0  ; i--){
      printf("\n vetor[%d]: %d", i,  vetor[i]);
      }


return 0;
}
