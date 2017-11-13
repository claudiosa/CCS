
#include <stdio.h>
#include <math.h> 
#include <stdlib.h> 
int main (void) {
    
   int n , k ; // ate N
   float serie_1 = 0 , serie_2 = 0 ;
   printf("\n Digite n  e <Enter>:  "); 
   scanf("%d", &n );
   printf("\n Digite  k e <Enter>:  "); 
   //fflush(stdin); sem espacos no scanf ....
   scanf("%d", &k );
   printf("\n LIDOS %d e  %d ", n , k );
     
   // METODO 01
   for(int j = 2, i=1, cont=0 ; cont < k ; i*=2, j*=2, cont++)
   {
     serie_1 = serie_1 + (float)(i*n) / ((j*n)+j); 
	}
   
   
   // METODO 02
   for(int j = 1, i=0 ; i < k ; i++,  j*=2) // i eh o cont
   {
     serie_2 = serie_2 + (float)(n*(pow(2,(j-1))))/(pow(2,j)*n + pow(2,j)); 
   }
   
   
   // SAIDAS 
    printf("\n Serie final: %6.4f \n", serie_1);
    printf("\n Serie final: %6.4f \n", serie_2);
    printf("\n Erro absoluto float: %20.10f \n", fabs(serie_1 - serie_2) ); 
   
   return 0;
}
