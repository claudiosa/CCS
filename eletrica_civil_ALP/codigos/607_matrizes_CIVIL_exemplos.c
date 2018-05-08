#include <stdio.h>
//:~/ccs$ g++ 600_le_escreve_2D.cpp 
//:~/ccs$ ./a.out < entrada_2D.txt
// #define L 10

int main (void)
{
  int L, C;  // virah do arquivo texto
  scanf("%d %d", &L, &C);  // lendo
  printf("\nLinhas: %d Colunas: %d \n", L, C);
  
  // apos termos a leitura de  L e C .... 
  // vamos criar e ler a matriz 
  int matriz[L][C];
  int i, j; 

/* LEITURA */ 
  for (i = 0; i < L; i++)
    for (j = 0; j < C; j++)
	  {scanf("%d ", & matriz[i][j] );
	   printf ("(%d:%d): %d\t", i,j, matriz[i][j]);
  }
	

printf("\n RESULTADOS ==================================\n");


int mult_3 = 0;
for (i = 0; i < L; i++)
  {for (j = 0; j < C; j++)
   {
	 if( matriz[i][j]%3 == 0 )
	 mult_3++; 
   }	  
  }
printf("\n MULTIPLOS DE 3: %d\n\n" , mult_3);	
//1a. Calcular a SOMA de TODOS elementos da matriz
int soma = 0;
for (i = 0; i < L; i++)
	for ( j = 0; j < C; j++)
		soma = soma + matriz[i][j];
printf("\n Soma = %d\n\n", soma);
//2a. Calcular quantos impares
//e quantos pares tem a matriz
int cont1=0,cont2=0;

for(i=0;i<L;i++)
for(j=0;j<C;j++)
{
	if ( matriz[i][j]%2==0)
	cont1++;
	else
	cont2++;
}
printf("Par:%d\n",cont1);
printf("Impar:%d",cont2);
	

//3a. IMPRIMIR a matriz por linha 
// MAS EM ORDEM INVERSA		

//4a. IMPRIMIR a matriz por coluna 
// MAS EM ORDEM INVERSA

for (i = 0; i < L; i++)
  { for (j = C-1; j >=0 ; j--)
	   printf ("(%d:%d): %d\t", i,j, matriz[i][j]);
  // saiu do for acima 	   
  printf ("\n");
 } // fim do  2o. for
   
				
			
//5a. Calcular a soma das DUAS diagonais
// da MATRIZ
soma = 0;
for (i = 0; i < L; i++)
  for ( j = 0; j < C; j++)
	{if ( i==j )
	 {soma = soma + matriz[i][j];
	  printf("=>[%d %d]:%d\t", i, j, matriz[i][j]); 	
	 }
	 if ( (i+j) == (L - 1) )
	 {soma = soma + matriz[i][j];
	  printf("=>[%d %d]:%d\t", i, j, matriz[i][j]); 	
	 }
	}
printf("\n Soma das diagonais = %d\n\n", soma);
//6a. Imprima a matriz TRANSPOSTA
//ideia de aluno: cria matriz2[C][L]

//7a. Substituir na MATRIZ todos multiplos			
//de 3 por 9999
			

			
			
			
			
			
			
			
			
			
			
 /* ESCREVENDO */			
 for (i = 0; i < L; i++)
  {
   for (j = 0; j < C; j++)
    printf ("m(%d,%d) = %d\t", i, j, matriz[i][j]);
	
	printf ("\n");
   } // fim do  2o. for
     
   printf("\n Profs. are humans !!!! \n\n");

  return 0;
}
