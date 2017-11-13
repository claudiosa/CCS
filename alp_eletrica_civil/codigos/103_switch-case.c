#include <stdio.h>

int main( void )
{
     char letra;
     printf("\t ENTRADA (uma letrinha): ");
     scanf("%c", &     letra);
     printf("\t LEU (uma letrinha) %c: ", letra);
     switch(letra)
     {
         case 'n':
           {		   
			   printf("\n Case 1: Vou para o NORTE: %c", letra);
			   break;
		   } 	   
		 case 's':
           {		   
			   printf("\n Case 2: Vou para o SUL: %c", letra);
			   break;
		   } 
		   case 'o':
           {		   
			   printf("\n Case 3: Vou para o OESTE: %c", letra);
			   break;
		   } 	   
		 case 'l':
           {		   
			   printf("\n Case 4: Vou para o LESTE: %c", letra);
			   break;
		   } 
         default:
           { 
           printf("\n Default: Voce NAO digitou \n nenhuma dos 4 pontos cardeais ");
           break;
	       } 
    }
    return (1);
}
