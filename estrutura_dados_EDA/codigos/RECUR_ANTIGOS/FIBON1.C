/* Compute Fibonacci numbers::
	fib(0) = 1
	fib(1) = 1
	fib(n) = fib(n – 1) + fib(n – 2)
*/
#include<stdio.h>
unsigned int fib( unsigned int n );

void main()
{
   int i;
	FILE *pt;
	pt = fopen("temp.txt","wt");

  for (i = 0; i <= 13 ; i++)
	fprintf(pt,"\nO numero de Fibonacci de %d eh:: %d", i, fib (i));
	getchar();
	fclose(pt);
}

unsigned int fib( unsigned int n )
{
/*1*/     if( n <= 0 )
/*2*/            return 0;
/*3*/     else
			 if    ( n == 1 )
/*4*/            return 1;
			 else
/*5*/            return( fib(n-1) + fib(n-2) );
}

 /* analise da complexidade ...
 If n = 0 or n = 1, then the running
 time is some constant value, which is the
 time to do the test at line 1 and return.
 We can say that T(0) = T(1) = 1, since
 constants do not matter. The running time
 for other values of n is then measured
 relative to the running time of the base case.
 For n > 2, the time to execute the function is
 the constant work at line 1 plus the work at
 line 3. Line 3 consists of an addition and two
 function calls. Since the function calls are
 not simple operations, they must be analyzed
 by themselves. The first function call is
 fib(n - 1) and hence, by the definition of T,
 requires T(n - 1) units of time.
 A similar argument shows that the second
 function call requires T(n - 2) units of time.
 The total time required is then T(n - 1) + T(n - 2) + 2,
 where the 2 accounts for the work at
 line 1 plus the addition at line 3.
 Thus, for n ³ 2, we have the following formula
 for the running time of fib(n):
T(n) = T(n – 1) + T(n – 2) + 2

*/
