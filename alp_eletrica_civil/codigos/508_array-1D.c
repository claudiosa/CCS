
// SOMA DO CONTEUDO DE UM VETOR
#include <stdio.h>
int main(){
     int vetor[] = {3, 41, 1, 2 ,6, 7, 8, 9, -9, -7};
     // criando um vetor com 10 posicoes
     int i, n, soma = 0; //SOMA EH INTEIRO
     int menor , MAIOR;
     menor = MAIOR = vetor[0];
     
     n = (float) (sizeof(vetor) / sizeof(int));//coerse ... coerção   
     // forçando que a divisão ocorra como fosse para
     // reais
     printf("\n NUM de Bytes dos inteiros: %zu", sizeof(int));  
     printf("\n Tamanho do vetor: %zu", sizeof(vetor));
     printf("\n Numero de elementos  do vetor: %d\n\n", n);
     for(i=0; i < n ;  i++ ){
     printf("\n PARCIAIS: %d || %d || %d",  vetor[i], soma, (soma +  vetor[i]) );
     soma = soma +  vetor[i];
      
     if(MAIOR  < vetor[i]) { // TROCA
		 MAIOR = vetor[i];}
  
     if(menor  >= vetor[i]) { // TROCA
		 menor = vetor[i];}
 
     }
     printf("\n Soma FINAL: %d", soma);
     float MEDIA = (float) soma/n;
     printf("\n Valor Medio: %0.3f\n", MEDIA );
     printf("Valor Medio: %0.3f\n", (float) soma/n );
     for(i=0; i < n ;  i++ ){
     printf("     V[%d]: %d", i,  vetor[i]);
     }
    
     printf("\n menor: %d", menor );
     printf("\n MAIOR: %d", MAIOR );
 
 return 0;
}
