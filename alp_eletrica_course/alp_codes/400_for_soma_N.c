#include <stdio.h>
 
int main () {

   /* local variable definition */
   int S = 0; 
   int N;
   printf(" Digite um inteiro MAIOR que 0 :");
   scanf("%d", &N );
   
   /* do loop execution */
   for(int cont = 0 ; cont <= N; cont ++)
    {
      printf("Valor de CONT e S: %d %d\t", cont, S);
      S = S + cont;
     };
 
   printf("\n Valor de 1 até %d  é igual: %d \n", N, S);
   return 0;
}
