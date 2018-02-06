
// EH PALINDROMO PAR, IMPAR ou NAO?
#include <stdio.h>

void imp_vetor(int vetor[], int tam);

int main(){
     int vetor[] = { 1, 2 ,6, 7, 6, 2, 1};
     //int vetor[] = {  2  };
     // criando um vetor com xxxxposicoes
     int i, j; // alguns contadores
     int chave = 1; // usando CHAVE ou flag
     int n = (int) (sizeof(vetor) / sizeof(vetor[0]));//coerse ... coerção   
     // forçando que a divisão ocorra como fosse para
     // reais
     printf("\n NUM de Bytes dos inteiros: %zu", sizeof(int));  
     printf("\n Tamanho do vetor: %zu", sizeof(vetor));
     printf("\n Numero de elementos  do vetor: %d\n\n", n);
     int METADE = int(n/2);
     printf("\n METADE DO VETOR: %d\n\n", METADE );
     
     for(i=0 , j= (n-1) ; i < METADE ;  i++, j-- )
     { 
       if(vetor[i] != vetor[j]) { 
		   chave = 0 ; // TROCA ... nao eh palindromo
		   break;}
     }// fim do FOR
     
     // IMPRIMINDO RESULTADOS
     if(chave == 1)
     {
			 if( (n % 2) == 0) // comprimento par ou impar
			 { printf("\n O vetor ..");
			   imp_vetor(vetor, n);
			   printf("\n eh palindromo PAR ....");	 
			 }
			 else
			 { printf("\n O vetor ..");
			   imp_vetor(vetor, n);
			   printf("\n eh palindromo IMPAR ....");	 
			 }   
       } 
       else
     printf("\n O INFELIZ NAO eh palindromo  ....");	      
 
 return 0;
}


void imp_vetor(int vetor[], int tam)
{   
     for(int i=0; i < tam ;  i++ )
     {
     printf(" :: V[%d]: %d", i,  vetor[i]);
     }
    return;
}
    
