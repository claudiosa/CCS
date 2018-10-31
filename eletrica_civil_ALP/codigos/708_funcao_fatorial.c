#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

long int  func_fat( int ) ;

int main(void) {

long int RESPOSTA;
int x, n;

printf("\n Quanto n voce quer? " );
scanf("%d" , &n);

for (x = 1; x <= n; x++)
{
RESPOSTA = func_fat(x);
printf("\n %d tem o valor do fatorial igual: %ld", x, RESPOSTA );
}
printf("\n \n ACACOU O MAIN \n" );
return(1);
} // FIM DO MAIN


/////////////////////////////////////////////////////////////////

long int func_fat( int n)
{
  long int Resp_fat;
  Resp_fat = 1;
  for ( ; n > 1; n-- )
  {
     Resp_fat = Resp_fat * n;
  };


  return(Resp_fat)  ;
}
