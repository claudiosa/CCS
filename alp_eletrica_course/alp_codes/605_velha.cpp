
// Imprimindo o conteudo de um vetor.....
#include <stdio.h>
#define N 3
int main()
{
     char velha[N][N] = 
        {'-' , '-' , '-', 
		 '-' , '-' , '-',
		 '-' , '-' , '-'};

  int i,j;
  /* ESCREVENDO */			
  for (i = 0; i < N; i++)
    {
	 for (j = 0; j < N; j++)
		  printf ("| %c ", velha[i][j]);
	  	  printf ("|\n");
     } // fim do  2o. for

// FORA DO FOR
printf (" APRENDIZAGEM m(%d,%d) = %c\t", i, j, velha[i][j]);
printf (" APRENDIZAGEM m(%3,%3) = %c\t", velha[3][3]);	  	  

int x,y; // coordenadas de leitura

for(int k = 0; k < N*N; k++)
 {
    printf (" \n DIGITE as coordenadas (i,j): ");
    scanf(" %d  %d", 	&x, &y );
    printf("ESCREVE %d  %d", 	x, y);
      	  
	 if( (x<0 || x>2) || (y<0 || y>2))
	 break; // INTERROMPE o LACO
	 
	printf ("\n DIGITE o caracter: ");
    fflush(stdin); // quando se le caracter
    scanf(" %c", &velha[x][y]);  	  
	 
 /* ESCREVE O TABULEIRO  */			
  for (i = 0; i < N; i++)
    {
	 for (j = 0; j < N; j++)
		  printf ("| %c ", velha[i][j]);
	  	  printf ("|\n");
     } // fim do  2o. for
   }  
  
  } 
// FIM DO FOR
//printf("\n TERMINO DO FOR \n");
 /* ESCREVE O TABULEIRO  			
  for ( i = 0; i < N; i++)
    {
	 for ( j = 0; j < N; j++)
		  printf ("| %c ", velha[i][j]);
	  	  printf ("|\n");
     } // fim do  2o. for
   }  
*/
return 0;
}
