// Entrada via ARQUIVO
/*
 * $ ./a.out <  entrada_array_1d.txt
 * 
 */ 
#include <stdio.h>
int main(){
/*   Estrategia 2 de inicializar o MAIOR e o menor 
 	 int MAIOR = -9999; // UM VALOR BEM PEQUENO
	 int menor = 9999; // UM VALOR BEM GRANDE
	 */ 
	 int MAIOR, P_M, menor, p_m;
	 int tamanho;
	 scanf("%d", &tamanho);
	  
    int vetor[tamanho];
    // LEITURA DO VETOR 
    for(int i=0; i < tamanho ; i++ ){
	   scanf("%d", &vetor[i]);
    }
    
    // Estrategia 2 de inicializar o MAIOR e o menor 
    MAIOR = vetor[0];
    menor = vetor[0];
    P_M = 0;
    p_m = 0;
    
    // LACO DE VERIFICACAO NO VETOR 
    for(int i=0; i < tamanho ; i++){
      if( vetor[i] >= MAIOR)
         { // efetue a troca de valores
		   MAIOR = vetor[i];
		   P_M = i;
		   printf("\t TROCOU ->");
		 }	 
      
      if( vetor[i] <= menor)
         { // efetue a troca de valores
		   menor = vetor[i];
		   p_m = i;
		   printf("\t trocou ->");
		 
		 }	 
      
      printf("\t vetor[%d]: %d", i,  vetor[i]);
     } // fim do for
     
      printf("\n\n O MAIOR eh: %d :: Posicao: %d", MAIOR, P_M );
      printf("\n o menor eh: %d  :: posicao: %d\n", menor, p_m );
      printf("\n Profs. are humans !!!! \n\n");
  
return 0;
}

