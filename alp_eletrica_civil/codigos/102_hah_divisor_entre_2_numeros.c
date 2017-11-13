#include <stdio.h>

int main()
  {
	int a, b, MAIOR, MENOR, resultado_div;

//   div_t saida; VEJAM o tipo
//   saida = div(27, 4) == 27%4

	 printf("\n ENTRADA de 2 NUMEROS (separados por espacos): ");
	 scanf("%d   %d",  & a, & b );
//ESCRITA DE VALORES	  
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

  if(MENOR == 0)
	{
	printf("\n O MENOR EH um ZERO .... ");
	printf("\n .... SAINDO .... \n");
	return(0); // EIS o uso deste codigo
	}
    resultado_div = MAIOR % MENOR;
  
  if(resultado_div == 0)
	 {
		printf("\n SÃO DIVISIVEIS ENTRE SI ....");
	 }
	 else	
	 {
		printf("\n NÃO DIVISIVEIS ENTRE SI ....");
	 }
    
 printf("\n \n Profs. are humans !!!! \n\n");
 return(1);
}
