
// EH PALINDROMO PAR, IMPAR ou NAO?
#include <stdio.h>

#define LINHA 60
int main(){
     char vetor[] = "12621"; // = { '1', '2' ,'6', '6', '2', '1'};
     
     // criando um vetor com xxxxposicoes
     int i, j; // alguns contadores
     int chave = 1; // usando CHAVE ou flag
     int n = (int) (sizeof(vetor) / sizeof(vetor[0]));//coerse ... coerção   
        // forçando que a divisão ocorra como fosse para
     // reais
     printf("\n NUM de Bytes da celula: %zu", sizeof(vetor[0]));  
     printf("\n Tamanho do vetor: %zu", sizeof(vetor));
     printf("\n Numero de elementos  do vetor: %d", n);
     int METADE = int ((n-1)/2);  
     printf("\n METADE DO VETOR: %d\n", METADE );
     
     for(int j=1; j < LINHA; j++)
     printf("=");
     
     // o menos 2 foi para descontar o \0 no final
     for(i=0 , j= (n-2) ; i < METADE ;  i++, j-- )
	     { 
	       if(vetor[i] != vetor[j]) { 
			   chave = 0 ; // TROCA ... nao eh palindromo
			   break;}
	     }// fim do FOR
     
     // IMPRIMINDO RESULTADOS
     if(chave == 1)
     {      // removento o \0
			 if( ((n-1) % 2) == 0) // comprimento par ou impar
			 { printf("\n O vetor .. %s", vetor);
			   printf("\n eh palindromo PAR ....");	 
			 }
			 else
			 { //printf("\n %d O vetor .. %s", (n-1) % 2, vetor);
			   printf("\n O vetor .. %s", vetor);	 
			   printf("\n eh palindromo IMPAR ....");	 
			 }   
       } 
       else
      printf("\n O INFELIZ NAO eh palindromo  ....");	      
      
      
 return 0;
}

