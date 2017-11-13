#include <stdio.h>
int main(void) {
	int M, N, l, c, soma=0;
	
	scanf("%d %d", &M, &N); // leitura DIMENSOES
	int mat[M][N]; // matriz criada
	
//LEITURA	
	for(l=0; l<M; l++)
	  { for(c=0; c<N; c++)
		   { scanf("%d",&mat[l][c]);
		   }
		}      
	       
//IMPRESSAO	       
	for(l=0; l<M; l++)
	  { for(c=0; c<N; c++)
		   {
			printf("[%d][%d]:%d  ",l,c, mat[l][c]);
	       } 
	     printf("\n");   
       }
       
printf("\nTRANSPOSTA \n");       
  for(c=0; c<N; c++)
	  { for(l=0; l<M; l++)
		   {
			printf("[%d][%d]:%d  ",l,c, mat[l][c]);
	       } 
	     printf("\n");   
       }
              
//T1: IMPRIMIR a MATRIZ em ORDEM INVERTIDA (do fim para o inicio)
printf ("\nT1: MATRIZ TODA INVERTIDA \n");
for(l=(M-1); l>=0; l--)
	  { for(c=(N-1); c>=0; c--)
		   {
			printf("[%d][%d]:%d  ",l,c, mat[l][c]);
	       } 
	     printf("\n"); 
       }

//T2: IMPRIMIR o maior e o menor valor da  MATRIZ 
int maior, menor;
maior = mat[0][0];
menor = mat[0][0];
for(l=0; l<M; l++)
	  { for(c=0; c<N; c++)
		   {
			if(maior < mat[l][c]){
			maior = mat[l][c];}
			if(menor > mat[l][c]){
			menor = mat[l][c];}
	       }    
       }
printf("\nT2: o MAIOR e o menor de toda matriz\n Maior: %d \n Menor: %d \n", maior, menor );

//T3: A SOMA DE TODOS OS ELEMENTOS PARES DA MATRIZ (FACIL)
	for(l=0; l<M; l++)
	  { for(c=0; c<N; c++)
		   {
			if( mat[l][c]%2 == 0)
			soma= soma + mat[l][c];
			  } 
	      }
	printf("\nT3:Soma final:%d\n", soma);
	
//T4: IMPRIMA A SOMA DESTA MATRIZ COM ELA PROPRIA
printf("\nT4: IMPRIMA A SOMA DESTA MATRIZ COM ELA PROPRIA\n");
	int mat2[M][N];
	for (l=0; l<M; l++)
	{
		for (c=0; c<N; c++)
		{
			mat2[l][c]=2*mat[l][c];
			printf ("%d ", mat2[l][c]);
		}
		printf ("\n");
	}
       
return 1;
}

	
