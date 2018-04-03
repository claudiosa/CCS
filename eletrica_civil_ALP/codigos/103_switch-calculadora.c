#include <stdio.h>
#include <math.h>
#include <stdlib.h> // funcao system 
/* CALCULADORA BASICA  */ 
int main( void )
{    
	 int N1, N2; 
     char OP;
     float RES = 0.0;
     
     do
     {
	 //system("clear");	 
     printf("\n Digite DOIS N1 e N2 e operandos \n e uma operacao {+, -, / ou /} : ");
     printf("\n Digite f ou F no operando para terminar: ");
     scanf("%d %d %c", &N1, &N2, &OP);
     printf("\n LEU:\t %d\t %d\t %c: ", N1, N2, OP);
     switch(OP)
     {
         case '+':
           {   RES = N1+N2;
			   break;         } 	   
		 case '-':
           {   RES = N1-N2;
			   break;         } 	   
		   case '*':
           {   RES = N1*N2;
			   break;         } 	      
		 case '/':
           {   RES = (float) N1/N2;
			   //FUNCAO: coersao ou conversao de tipos
			   break;          } 	   
         default:
            printf("\n Default: DIGITE OPERACAO ALGO VALIDO \n \n");
         
    }//FIM DO SWICTH
    
    if (RES != 0.0)
    printf("\n O resultado é : %6.2f\n\n", RES);
    getchar(); 
    
    } while( !((OP == 'f') || (OP != 'F')) );
    
       
    return (1);
}
