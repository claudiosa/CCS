#include <stdio.h>
#include <math.h>
int main(void)
	{ // declara variaveis 
	  int a = 2, b = 3; // com atribuicoes
	  float res_1, res_2; // idem sem atribuicao
	  float fim_1 = a^2;
	  //float fim_2 = (3.567)**2; ==> NAO VALE em C
	  // CALCULO do ITALO
	  res_1 = sqrt( (a*a) + (b*b) ); //double
      res_2 = sqrt( pow(a,2) + pow(b,2) );    	  	  	  	  
      // ESCRITA DE VALORES	  
      
	  printf("\n SAIDA: \n");
	  printf(" R1: %.4f \t R2: %.4f", res_1, res_2 );
	  printf(" Potenciacao: %.4f ", fim_1 );
	 
	  printf("\n \tProfs are humans !!!! \n\n");
 
 return(1);
}
