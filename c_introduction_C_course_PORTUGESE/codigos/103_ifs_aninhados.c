#include <stdio.h>

int main(void)
  {
	int N; // a ser lida

	printf("\n ENTRADA  1 valor: ");
	scanf("%d",  & N ); //leitura
	printf("\n ==> %d: ", N);
	
    //CALCULOS	  
   printf(" SAIDA: \n");
   if(N >= 500) // COMECA AQUI
	 { // SIM
	   printf("\n MAIOR que 500 !!!");
	 }
   else { 
	    if (N >= 400)
	    { // SIM
	     printf("\n MAIOR que 400 !!!");
	    }
	    else {     
			 if (N >= 300)
	          { // SIM
	          printf("\n MAIOR que 300 !!!");
	          }
	          else
	          { // NAO
	          printf("\n MENOR que 300 !!!");
	          }
	         }
	    } // fim do  1o. IF
	    
 printf("\n ====================\n");
	
  return(1);
 
 }// FIM DO MAIN
