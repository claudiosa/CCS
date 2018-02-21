// SOMA DO CONTEUDO DE UM VETOR
// IMPRIME INVERTE ....
#include <stdio.h>
int main(void){

	 int i, N, soma=0;
	 printf("\n Quantos elementos no VETOR: ");
     scanf("%d", &N);
     printf("\n Numero de elementos  do vetor: %d", N);
     
     // criando um vetor com N posicoes
     int vetor[N];
     
     // leitura ou preenchimento do vetor     
	 for(int i=0; i < N ; i++ ){
	   printf("\n VETOR[%d]: ", i);	 
	   scanf("%d", &vetor[i]);
     }
    
    // IMPRIMINDO INVERTIDO    
	for(i=N-1 ; i >= 0 ;  i-- ){
     printf(" %d", vetor[i] );
     }
     if(getchar())
     printf("pausa");

    // SOMANDO 
     for(i=0; i < N ;  i++ ){
    // printf("\n PARCIAIS: %d || %d || %d",  vetor[i], soma, (soma +  vetor[i]) );
     soma = soma +  vetor[i];
     }
     printf("\n Soma FINAL: %d", soma);
     float MEDIA = (float) soma/N;
     //float MEDIA = (1.0 * soma)/N;
     printf("\n Valor Medio: %0.3f\n", MEDIA );
     
 return 0;
}
