#include <stdio.h>

int main()
  {
	int a, b, MAIOR, MENOR, resultado_div;
	
	 printf("\n ENTRADA de 2 NUMEROS (separados por espacos): ");
	 scanf("%d   %d",  & a, & b );
//  ESCRITA DE VALORES	  
	 printf(" SAIDA: \n");
	 if(a>=b)
	 {
		MAIOR = a;
		MENOR = b;
	 }
	 else	
	 {
		MAIOR = b;
		MENOR = a;
	 }
  printf("\n MAIOR: %d :  MENOR: %d",MAIOR,MENOR );
// retorna o resto da divisao: %  
  resultado_div = MAIOR % MENOR;
  
  if(resultado_div == 0)
	 {
		printf("\n SÂO DIVISIVEIS ENTRE SI ....");
	 }
	 else	
	 {
		printf("\n NÂO DIVISIVEIS ENTRE SI ....");
	 }
    
  printf("\n \n Profs. are humans !!!! \n\n");
 return(1);
}
