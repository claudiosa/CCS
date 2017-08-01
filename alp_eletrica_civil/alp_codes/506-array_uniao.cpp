#include <stdio.h>
int main(){
  
	 int B []= {1,9,5,2,8,3};	 
     int A []= {-1, 0, 1, 9, 5, 2, 8, 3, 6, 7};	
	 // A variavel REG vai armazenar o MAIOR, menor e
	 // as posicoes destes do vetor
	 int tam_A = (int)sizeof(A)/sizeof(int);
	 int tam_B = (float)sizeof(B)/sizeof(int);
	 int num_ocorr = 0;
	 printf("TAMANHOS A e B: %d %d\n" , tam_A, tam_B); 
	 
	 
    for(int i=0; i < tam_A ; i++ )
     {
      for(int j=0; j < tam_B ; j++ )
       {
	     if (A[i] == B[j])
	     {num_ocorr++;
		  printf(" %d " , A[i]);
		 }
		}
	  }	   
	  	 
	int tam_U = (tam_A + tam_B) - num_ocorr;		 
	int UNIAO[tam_U];
			 
	for(int i=0; i < tam_A ; i++ )
     {
		UNIAO[i] = A[i];
	 }	 
	
	
	int k = tam_A, i, j;
	
	// Verifica se todos elementos de B estão no conjunto união até
	// o momento
    for(i=0; i < tam_B ; i++ )
     {
      for(j=0; j < k ; j++ )
       {
		 if (B[i] == UNIAO[j])
	 	  {
			  break; // elemento já esta contido ... 
	      }   // break: sai do escopo IMEDIATO -- laço FOR
		}
		if(j == k) // como não pertence ... insere na UNIAO
		{
			UNIAO[k] = B[i];
			k++;
		}
	  }	   	 
    
    printf("\n \n UNIAO FINAL:");
    
    for(int i=0; i < tam_U ; i++ )
     {
	   printf("%d  ",	 UNIAO[i]);
	 }	 
	
   
      printf("\n\n Profs. are humans !!!! ");

return 0;
}
