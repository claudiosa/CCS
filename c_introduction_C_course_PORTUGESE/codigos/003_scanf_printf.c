#include <stdio.h>

int main()
	{
	  unsigned int SEM_sinal_INT; //Reads an unsigned integer to be stored in an unsigned int.
	  float N_01; //NUM_NOTACAO_CIENT_01;
	  long double N_02; // NUM_NOTACAO_CIENT_02;

// NOTACAO CIENTIFICA para os ELETRICOS	  
// %e 	Reads a floating-point number in exponential (scientific notation) 	1.050000e+01

// LEITURA DE VALORES
// scanf("FORMATACAO DA LEITURA", enderecos de variaveis);
	 printf("\n ENTRADA u e real++ (separados por espacos): ");
	 scanf("%u %e",  & SEM_sinal_INT, & N_01);
	 scanf(" %Lf", & N_02);

// ESCRITA DE VALORES	  
// printf("FORMATACAO DA ESCRITA", SOH as variaveis);	 
	 printf(" SAIDA: \n");
	 printf(" Unsigned: %u :  N_01: %e :  N_02: %Lf", 
 		SEM_sinal_INT,  N_01,  N_02 );
	 printf("\n \n Profs. are humans !!!! \n\n");
 return(1);
}

/*
 
 ENTRADA u e real++: 34 5.123456789 987.654321                        
 SAIDA: 
 Unsigned: 34 :  N_01: 5.123457e+00 :  N_02: 987.654321
 Profs. are humans !!!! 

*/
