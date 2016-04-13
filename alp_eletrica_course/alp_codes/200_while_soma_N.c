#include <stdio.h>
 
int main () {

   /* local variable definition */
   int S = 0; 
   int N;
   printf(" Digite um inteiro MAIOR que 0 :");
   scanf("%d", &N );
   
   /* do loop execution */
   while( N > 0 ) 
   {
      printf("Valor de N: %d\t", N);
      S = S + N;
      N = N -  1;
   } 
 
   printf("\n Valor desta Soma é: %d \n", S);
   return 0;
}
