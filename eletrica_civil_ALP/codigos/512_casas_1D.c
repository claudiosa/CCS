
// SOMA DO CONTEUDO DE UM VETOR
// INVERTER UM VETOR etc
#include <stdio.h>
int main(){
     int N; // Tecnica OBRIGATORIA
    // printf("\n Digite o Tamanho" );
     scanf("%d" , &N ); // Tamanho do vetor
     int casas[N]; // variavel vetor CASA é criado de tamanho N
     int i, pop=0;

     for(i=0; i < N ;  i++ ){
     //printf("\n Qual o valor da casa[%d]:",i);
     scanf("%d", &casas [i] );
     pop = pop + casas[i];
     printf("\n BOA PRATICA casa[%d]: %d || %d ", i, casas[i] , pop );

    }
     printf("\n Soma FINAL: %d\n", pop);

 //IMPRIMIR INVERTIDO

   printf("\n INVERTIDO \n" );
     for(i= (N-1) ; i >= 0 ;  i-- )
     {
     printf("\n Casa[%d]: %d  ", i, casas[i] );
     }

   //IMPRIMIR INVERTIDO
   printf("\n INVERTIDO de novo\n" );
    for(i = 0 ; i < N ;  i++ )
    {
      printf("\n %d : Casa[%d]: %d  ", i, (N-1)-i, casas[(N-1)-i] );
    }

// 2a. parte do problema
     int n_filhos = 0;
     for(i=0; i < N ;  i++ ){
     if( casas[i] > 2 )
     {
       //n_filhos = n_filhos + (casas[i]-2);
       n_filhos += (casas[i]-2);
     }
     printf("\n casa[%d]: %d || %d ", i, casas[i] , n_filhos);
     }
    printf("\n Soma n_filhos: %d\n", n_filhos);

    printf("\n Quantos bytes INTEIRO: %ld bytes" , sizeof(int));
    printf("\n Quantos bytes REAL: %ld bytes" , sizeof(float));
    printf("\n Quantos bytes DOUBLE: %ld bytes" , sizeof(double));
    printf("\n Quantos bytes tem: %ld bytes" , sizeof(casas));

 return 0;
}
