// Entrada via ARQUIVO
/*
 * $ ./a.out <  entrada_array_1d.txt
 * 
 */ 
#include <stdio.h>
int main(){

	 int MAIOR = -9999;
	 int menor = 9999;
	 int tamanho;
	 scanf("%d", &tamanho);
	  
    int vetor[tamanho];
    // LEITURA DO VETOR 
    for(int i=0; i < tamanho ; i++ ){
	   scanf("%d", &vetor[i]);
	   }
    
    
    // ESCRITA  DO VETOR 
    for(int i=0; i < tamanho ; i++){
      if( vetor[i] >= MAIOR)
         { // efetue a troca de valores
		   MAIOR = vetor[i];
		 }	 
      
      if( vetor[i] <= menor)
         { // efetue a troca de valores
		   menor = vetor[i];
		 }	 
      
      printf("\t vetor[%d]: %d", i,  vetor[i]);
     } // fim do for
     
      printf("\n\n O MAIOR eh: %d", MAIOR );
      printf("\n o menor eh: %d\n", menor );
      printf("\n Profs. are humans !!!! \n\n");
       
return 0;
}
