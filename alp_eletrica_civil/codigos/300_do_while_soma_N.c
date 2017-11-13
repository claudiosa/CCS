#include <stdio.h>
#include <stdlib.h>

int main (void) {

   /* local variable definition */
   int S = 0; 
   int N , i = 0;
   printf(" Digite um inteiro MAIOR que 0 :");
   scanf("%d", &N );
   i = N;
   system("clear"); // LIMPA
   /* do loop execution */
   do {
       S = S + i;
       printf("\n  ==>\t CONT i: %d \t S:%d", i, S);
       i = i - 1;
	         
   //} while( i <= N );
   } while( i >= 0 ); // FIM DO BLOCO ou do DO-WHILE
 
   printf("\n Valor desta Soma é: %d \n", S);
   return 0;
}
