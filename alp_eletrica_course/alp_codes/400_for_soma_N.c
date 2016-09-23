#include <stdio.h>
 
int main () {
   int S = 0; // variavel para guardar a soma
   int N; // ate N
   printf(" Digite um inteiro N MAIOR que 0 :");
   scanf("%d", &N );
   /* do loop execution */
   for(int cont = 0 ; cont <= N; cont ++)
   // cont ++  <=> cont = cont + 1
    {
      printf("\n CONT: %d \t S:%d", cont, S);
      S = S + cont;
     };
 
   printf("\n Valor de 1 até %d  a soma é igual: %d \n", N, S);
   return 0;
}
