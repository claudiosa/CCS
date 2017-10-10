#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int main(void){
	 int N, i, j, chave = 1;
	 printf("\n Numero de elementos  do vetor (N>=1): "); 
	 scanf("%d" , & N);
     int vetor[ N ] ;
     
     // ACRESCENTAR FOR para LEITURA E ESCRITA
      for(i=0; i < N ;  i++ ){
	   printf("\n Entrada de vetor[%d] : " , i);  
       scanf("%d" , &vetor[i]); // le 
       printf("\t Leu vetor[%d]: %d", i,  vetor[i]); // escreve
      }
     //-------------------------------------------------------------
        
 //for(i=0 , j= (n-1) ; (abs(i-j) >= 1 && i < j) ;  i++, j-- )
   for(i=0 , j= (N-1) ; (j-i) >= 1 ;  i++, j-- )
     { 
       if(vetor[i] != vetor[j]) 
       {
		printf("\n BREAK ... I: %d \tJ: %d", i,j); 
		chave =  0;
		break;
	   }// fim do IF
	   printf("\n I: %d \tJ: %d", i,j);   	
      }// fim do FOR
     
     // IMPRIMINDO RESULTADOS
     // printf("\n FECHA COM => I: %d \tJ: %d", i,j);   
     if( chave == 1 )
     {
		if( (N % 2) == 0) // comprimento par ou impar
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
