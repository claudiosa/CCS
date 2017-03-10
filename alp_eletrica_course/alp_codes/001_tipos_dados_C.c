#include <stdio.h>
int main()
	{   // INICIO {
	  int X	              ;
	  float PI = 3.14	  ;
	  char  sexo = 'M'    ; 
	  char  nome[20] = "Isto eh uma string" ; 
	  bool  luz = true    ;
	  X = 2017            ;	  
// ESCRITA DE VALORES	  
// printf("FORMATACAO DA ESCRITA", SOH as variaveis);	 
	 printf(" SAIDA: \n");  // print + f = imprima no arquivo = te
	 printf(" Int: %d  Real: %f CARACTER: %c", 
	 X, PI, sexo );
	 printf("\n String: %s  finally :%b ", nome, luz); 
	 printf("\n \t Profs are humans !!!! \n\n");
 return(1);
} // fim do algoritmo
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
