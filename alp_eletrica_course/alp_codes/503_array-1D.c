// Entrada via ARQUIVO
/*
 * $ ./a.out <  entrada_array_1d.txt
 * 
 */ 
#include <stdio.h>
int main(){
/*
 double temp = (double) 1.0 /0.0;
 
 int POS_INF, NEG_INF;

  if(temp > 0)
  { POS_INF = temp ;
	NEG_INF = (-1)*temp ;
   }
  else
  { POS_INF = (-1)* temp ;
	NEG_INF = temp ;
   }

  printf("\n Positivo e Negativo infinitos: %d  %d", POS_INF,  NEG_INF);
*/     


	 int MAIOR = -9999; // UM VALOR BEM PEQUENO
	 int menor = 9999; // UM VALOR BEM GRANDE
	 int tamanho;
	 scanf("%d", &tamanho);
	  
    int vetor[tamanho];
    // LEITURA DO VETOR 
    for(int i=0; i < tamanho ; i++ ){
	   scanf("%d", &vetor[i]);
    }
    
    
    // LACO DE VERIFICACAO NO VETOR 
    for(int i=0; i < tamanho ; i++){
      if( vetor[i] >= MAIOR)
         { // efetue a troca de valores
		   MAIOR = vetor[i];
		   printf("\t TROCOU ->");
		 }	 
      
      if( vetor[i] <= menor)
         { // efetue a troca de valores
		   menor = vetor[i];
		   printf("\t trocou ->");
		 
		 }	 
      
      printf("\t vetor[%d]: %d", i,  vetor[i]);
     } // fim do for
     
      printf("\n\n O MAIOR eh: %d", MAIOR );
      printf("\n o menor eh: %d\n", menor );
      printf("\n Profs. are humans !!!! \n\n");
  
return 0;
}
