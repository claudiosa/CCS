#include <stdio.h>
int main(){
  
   int reg []= {-9999,9999,0,0};	 
  // A variavel REG vai armazenar o MAIOR, menor e
  // as posicoes destes, respectivamente,  no vetor 
  // simplesmente poderia ser	   int reg [4];
   int tamanho;
   scanf("%d", &tamanho);
	  
    int vetor[tamanho];
    // LEITURA DO VETOR 
    for(int i=0; i < tamanho ; i++ ){
	   scanf("%d", &vetor[i]);
    }
   // INICIALIZANDO O MAIOR E O MENOR ... uma estratégia
    reg[0] =  vetor[0];
    reg[1] =  vetor[0];	
	    
	
    // LACO DE VERIFICACAO NO VETOR 
    for(int i=0; i < tamanho ; i++){
      if( vetor[i] >= reg[0])
         { // efetue a troca de valores
		   reg[0] = vetor[i];
		   printf("\t TROCOU ->");
		   reg[2] = i; //tem a posicao do MAIOR
		 }	 
      
      if( vetor[i] <= reg[1])
         { // efetue a troca de valores
		   reg[1] = vetor[i];
		   printf("\t trocou ->");
		   reg[3] = i; //tem a posicao do menor
		  }	 
      
      printf("\t vetor[%d]: %d", i,  vetor[i]);
     } // fim do for
     
      printf("\n\n O MAIOR eh: %d", reg[0] );
      printf("\n O menor eh: %d", reg[1] );
      printf("\n Posicao do MAIOR valor %d", reg[2] );
      printf("\n Posicao do menor valor  %d", reg[3] );
      printf("\n\n Profs. are humans !!!! ");
  
return 0;
}
