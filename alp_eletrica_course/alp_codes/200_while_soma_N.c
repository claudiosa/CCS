#include <stdio.h>
 
int main () {
   int S = 0; 
   int N;
   printf(" Digite um inteiro MAIOR que 0 :");
   scanf("%d", &N );
   
   /* do loop execution */
   while( N > 0 ) 
   {
      printf("\n CONT N: %d \t S:%d", N, S);
      S = S + N;
      N = N - 1;
   } // FIM DO BLOCO ou do WHILE
 
   printf("\n Valor desta Soma é: %d \n", S);
   return 0;
}
