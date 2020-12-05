#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

long int  func_fat( int ) ; // DECLARAR A FUNCAO
// MOSTRAR QUE A FUNCAO EH VISIVEL NESTE ARQUIVO

int main(void) {

long int RESPOSTA;
int x, n;

printf("LONG bytes %ld\n", sizeof(long int) );
printf("INT bytes %ld\n", sizeof(int) );
printf("\n Quantos N voce quer? " );
scanf("%d" , &n);

for (x = 0; x <= n; x++)
{
RESPOSTA = func_fat( x );// 1, 2, 3, ... n argumento 1 por vez
printf("\n %d tem o valor do fatorial igual: %ld", x, RESPOSTA );
}
printf("\n \n ACABOU O MAIN \n" );
return(1);
} // FIM DO MAIN

/////////////////////////////////////////////////////////////////

long int func_fat ( int n )
{
  long int Resp_fat;
  Resp_fat = 1;
  printf("\n" );
  for ( ; n >= 1; n-- )
  {
     Resp_fat =  n * Resp_fat;
     printf("* ");
  };
   printf(" ==> na função!!!!" );
  return(Resp_fat)  ;
}


/////////////////////////////////////////////////////////////////
