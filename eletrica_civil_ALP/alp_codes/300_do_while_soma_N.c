#include <stdio.h>
 
int main () {

   /* local variable definition */
   int S = 0; 
   int N;
   printf(" Digite um inteiro MAIOR que 0 :");
   scanf("%d", &N );
   
   /* do loop execution */
   do {
       printf("\n CONT N: %d \t S:%d", N, S);
       S = S + N;
       N = N - 1;
   } while( N > 0 ); // FIM DO BLOCO ou do DO-WHILE
 
   printf("\n Valor desta Soma é: %d \n", S);
   return 0;
}
