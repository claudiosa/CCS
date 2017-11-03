#include <stdio.h>
#include <stdlib.h>
int main(void)
{
int r,a;
 
 for(a=0;a<20;a++)
 {
 r=rand()%100;
 printf("%d ",r);
 }

 return(0);
}

/*
void vetor_N_random( int vetor [N] )
{ 
	int x;
	
  for(i=0 ; i < N ; i ++)
	{
	j = 0;
	
	while (chave)
	{
	  while( j < i )
	  {
	   if(vetor[j] != x)	
	   { j++;	
	     x = rand()%100;
	   }
	  } 
	 
	 
	 
	vetor[i] = x;
	
   }
	
}
*/
