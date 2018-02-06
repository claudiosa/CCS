// Entrada via ARQUIVO
/*
 * $ ./a.out <  entrada_array_1d.txt
 * 
 */ 
#include <stdio.h>
#define   NUM_UM 1 // ILUSTRA O #define 
int main(){

	 int tamanho;
	 scanf("%d", &tamanho);
	  
    int vetor[tamanho];
    // LEITURA DO VETOR 
    for(int i=0; i < tamanho ; i++ ){
	   scanf("%d", &vetor[i]);
	   }
    
    // ESCRITA  DO VETOR 
    for(int i=(tamanho - NUM_UM); i >= 0  ; i--){
       printf("\t vetor[%d]: %d", i,  vetor[i]);
     } // fim do for
     
     printf("\n Profs. are humans !!!! \n\n");
       
return 0;
}
