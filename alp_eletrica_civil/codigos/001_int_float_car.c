#include <stdio.h>
int main()
	{
	  int num_inteiro	;
	  float num_real	;
	  char  UM_CARACTER ; 
	  
	  num_inteiro = 7777; // UMA ATRIBUICAO
	  num_real = 77.890	; // UMA ATRIBUICAO
	  UM_CARACTER = '#' ; // UMA ATRIBUICAO
	  char  UMA_CADEIA[] = "Isto eh uma string" ; 
	  	  
// ESCRITA DE VALORES	  
// printf("FORMATACAO DA ESCRITA", SOH as variaveis);	 
	 printf(" SAIDA: \n");
	 printf(" Int: %d  Real: %f CARACTER: %c", 
	 num_inteiro, num_real, UM_CARACTER );
	 printf("\n String: %s ", UMA_CADEIA); 
	 printf("\n \tProfs are humans !!!! \n\n");
 return(1);
}
/*
 * EDITE
 * SALVE
 * COMPILE: $ g++ 015_num_int.c 
 * EXECUTE: $ ./a.out 
 SAIDA: 
 Int: 7777  Real: 77.889999 CARACTER: #
 String: Isto eh uma string 
 	Profs are humans !!!! 
 */ 
