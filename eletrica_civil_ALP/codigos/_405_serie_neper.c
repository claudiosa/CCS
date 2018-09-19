#include <stdio.h>
#include <math.h> // necessaria devido pow
// gcc limite.c -lm
// ou g++ limite.c
int main (void) {
   int x	; // Variavel contador SEMPRE DO TIPO INTEIRO
   double  S_total = 0; //variavel para guardar a soma das medias de todos alunos
   double termo ;
   int N; // Quantos termos
   printf(" Digite um N grande: ");
   scanf("%d", &N ); // Lendo N
   //x = 0 ;
   //while(  x <= N )
   for( x = 1 ; x <= N ; x ++) //LACO - NUCLEO
   {
	//termo = pow((1 + (1.0*1)/x), x); // (1 + 1/x)^x
	termo = pow((1 + 1.0/x), x); // (1 + 1/x)^x
    S_total = S_total + termo ;
    printf("\n %d: S_parcial:%4.2f \t termo (tende a Neper-e): %4.6f ", x, S_total, termo );
     
   }; // ENCERRA O LACO
      
   
   printf("\n Soma desta SERIE: %4.8f \n", S_total);
   return 0;
}
