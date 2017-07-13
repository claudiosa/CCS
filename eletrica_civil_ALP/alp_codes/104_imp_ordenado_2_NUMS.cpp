
#include <stdio.h>

int main()
  {
	int a, b;
	printf("\n ENTRADA de 2 NUMEROS (separados por espacos): ");
	scanf("%d   %d",  & a, & b ); // & na leitura
// ESCRITA DE VALORES	  
	if(a >= b)
	 {
       printf("\n SAIDA: %d %d: ", b, a);
       printf("\n PASSEI com TRUE");
	 }
	 else	
	 {
		printf("\n SAIDA: %d %d: ", a, b);
		printf("\n PASSEI com ELSE = FALSE");
	 }
 
 printf("\n \n Profs. are humans !!!! \n\n");
 return(1);
}
