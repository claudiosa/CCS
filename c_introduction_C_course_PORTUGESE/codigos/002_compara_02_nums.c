#include <stdio.h>

int main(void)
{  // float eh num reais....
   int N_1, N_2; // variaveis criadas
   //https://www.tutorialspoint.com/cprogramming/c_data_types.htm
   // pergunta de aluno
   printf("\nTam INT: %ld bytes", sizeof(int));
   printf("\nTam FLOAT: %ld bytes", sizeof(float));
   printf("\nTam double float: %ld bytes", sizeof(double));
   
   printf("\n DIGITE DOIS NUMEROS: ");//escrita
   scanf("%d %d",& N_1 , & N_2  ) ; //leitura
   
   if ( N_1 > N_2 ) // CONDICAO LOGICA: {V,F}
	   {// caso verdade de  N_1 > N_2
		printf("\n MAIOR\t N1 = %d\n", N_1 );//escreve
	   } // IF SIMPLES .... SEM O ELSE -- TERMINOU AQUI
	    
    //else
   if ( N_1 < N_2 ) // CONDICAO LOGICA: {V,F}
	    {// caso FALSO  N_1 =< N_2
		// FORMATACAO DE SAIDA	
		printf("\n MAIOR\t N2 = %d\n", N_2 );//escreve
	    }
   //else
   if ( N_1 == N_2 ) // CONDICAO LOGICA: {V,F}
	    {// caso FALSO  N_1 =< N_2
		// FORMATACAO DE SAIDA	
		printf("\n SAO IGUAIS!!!\tN1:%d \tN2:%d \n", N_1, N_2 );//escreve
	    } // IF COMPLETO
	   
   return 1; // FIM
}
