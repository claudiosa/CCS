#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int main(void){
	
     int vetor[] = { 1, 2 ,6, 6, 2, 1};
     // ACRESCENTAR FOR para LEITURA E ESCRITA 
     int i, j; // INDICES contadores
     int n = (int) (sizeof(vetor) / sizeof(vetor[0]));//coerse ... coerção   
    
     printf("\n NUM de Bytes dos inteiros: %zu", sizeof(int));  
     printf("\n Tamanho do vetor: %zu", sizeof(vetor));
     printf("\n Numero de elementos  do vetor: %d\n\n", n);
          
     for(i=0 , j= (n-1) ; (abs(i-j) >= 1 && i <= j) ;  i++, j-- )
     { 
       if(vetor[i] != vetor[j]) 
       {
		printf("\n I: %d \tJ: %d", i,j);   
		break;
	   }// fim do IF
	   printf("\n I: %d \tJ: %d", i,j);   	
      }// fim do FOR
     
     // IMPRIMINDO RESULTADOS
     printf("\n FECHA COM => I: %d \tJ: %d", i,j);   
     if( abs(i-j) == 0)
     {
		if( (n % 2) == 0) // comprimento par ou impar
		 { printf("\n O vetor ... eh palindromo PAR ....\n");	 
		 }
		 else
		 { printf("\n O vetor ... eh palindromo IMPAR ....\n");	 
		 } //if int
      }//if ext 
       else
      {printf("\n O INFELIZ NAO eh palindromo  ....\n");
      } 	  	      
 
 return 0;
}
