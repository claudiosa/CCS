/*
 For instance, the following function is really
 just a simple loop and is obviously O (n):
unsigned int
*/
#include<stdio.h>
int soma( unsigned int n );
void main()
{
  int i;
  for (i = 0; i <= 10 ; i++)
	printf("\nA Soma de 0 ateh %d eh:: %d", i, soma (i));
	getchar();
}

int soma( unsigned int n )
	{
	/* int S_n; */
	if( n <= 0 )
		return 0;
	else
		return (soma(n-1) + n );
	/*
		ou
		S_n = soma(n-1) + n;
		return( S_n );
  */
}


