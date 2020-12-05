#include <stdio.h>
 
int main () {
   int S = 0; // variavel para guardar a soma
   int N; // ate N
   int x, cont;
   printf(" Digite um inteiro N MAIOR que 0 :");
   scanf("%d", &N );
   //N = 10; // fins de DDD 
   /* do loop execution */
   for(cont = 0 ; cont < N; cont ++)
   // cont ++  <=> cont = cont + 1
    {
	  scanf("%d", &x );
      printf("\n CONT: %d \t x:%d \t S:%d", cont, x, S);
      S = S + x;
     }; // FIM DO BLOCO ou fim do FOR
 
   printf("\n Valor de 1 até %d  a soma é igual: %d \n", N, S);
   return 0;
}
