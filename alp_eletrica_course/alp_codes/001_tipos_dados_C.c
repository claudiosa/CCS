#include <stdio.h>
int main()
	{   // INICIO { ... comentado
	  int ANO	              ;
	  float PI = 3.141519141519141519141519 ;
	  char  sexo = 'M'    ; 
	  char  nome[20] = "Isto eh uma string" ; 
	  bool  luz = true    ;
	  // ISTO EH UMA ATRIBUICAO
	  ANO = 2017            ;	  
// ESCRITA DE VALORES	  
/*
 f : eh file = arquivo
 stdin: standard input = teclado
 stdout: standard output = tela
 */
    printf("FORMATACAO DA ESCRITA \n");	 
	 printf(" SAIDA: \n");  // print + f = imprima no arquivo = te
	 printf(" Int: %d  Real: %6.4f || %20.20f CARACTER: %c", 
	 ANO, PI, sexo );
	 
	 ANO = ANO + 1; // ATRIBUICAO ... dif da MAT
	 printf(" ANO NOVO: %d", ANO );
	 
	 
	 printf("\n Cadeia STR: %s  finally :%d ", nome, luz); 
	 printf("\n \t Profs are humans !!!! \n\n");
 return(1);
} // fim do algoritmo
/*
 * EDITE
 * SALVE
 * COMPILE: $ g++ nome_do_programa.c 
 * EXECUTE: $ ./a.out  
 */ 
