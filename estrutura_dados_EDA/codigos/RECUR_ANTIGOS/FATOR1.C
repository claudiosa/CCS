/*
 For instance, the following function is really
 just a simple loop and is obviously O (n):
unsigned int
*/
#include<stdio.h>
int factorial( unsigned int n );
void main()
{
  int i;
  for (i = 5; i <= 7 ; i++)
	printf("\nO fatorial de %d eh:: %d", i, factorial (i));

	getchar();
}

int factorial( unsigned int n )
{
if( n <= 1 )
	return 1;
	else
return( n * factorial(n-1) );
}
/*
	This example is really a poor use of recursion.
	When recursion is properly used, it is difficult
	 to convert the recursion into a simple loop
	 structure. In this case, the analysis will
	 involve a recurrence relation that needs to be
	 solved
 */
