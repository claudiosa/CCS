#include <stdio.h>

int main()
	{
	  int num_inteiro;
	  char sexo;
	  float num_real;
// unsigned int Sem_sinal_INT;
// LEITURA DE VALORES	  
// scanf("FORMATACAO DA LEITURA", enderecos de variaveis);
	 printf("\n ENTRADA d c f: ");

	 scanf("%d %c %f",  & num_inteiro, & sexo, & num_real);
// ESCRITA DE VALORES	  
// printf("FORMATACAO DA ESCRITA", SOH as variaveis);	 
	 printf(" SAIDA: \n");
	 printf(" Int: %d  Char: %c Real: %f", 
		 num_inteiro, sexo, num_real );
	 printf("\n \n Profs are humans !!!! \n\n");
 return(1);
}