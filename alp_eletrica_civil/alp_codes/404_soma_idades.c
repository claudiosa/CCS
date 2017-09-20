#include <stdio.h>
 
int main (void) {
  
   printf("\n NUMERO DE ALUNOS : ");
   int N; // ate N
   scanf("%d", &N );
    
   int volta , S = 0 , idade;  
   int cont=0;
   // variavel para guardar a soma
  
   /* LACO DE EXECUCAO .... */
   //for(volta = 0 ; volta < N; volta ++)
   printf("\n Digite a sua idade :"); 
   scanf("%d", &idade );
    while(  idade != 0  )
  // for( ; idade != 0 ; )
   {
    S = S + idade;
    printf("\n IDADE: %d \t S:%d\t V:%d", idade, S, cont);
    printf("\n Digite a sua idade :"); 
    scanf("%d", &idade );
    cont++;
   }; 
   // FIM DO BLOCO ou fim do FOR
 
   printf("\n Valor de 1 até %d  a soma é igual: %d \n", N, S);
   return 0;

}
