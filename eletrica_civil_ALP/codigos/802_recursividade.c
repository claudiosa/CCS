#include <stdio.h>


int f_soma(int n, int *vetor[ n ] )
  {
	if (n == 0) 
	  {
	  return ( vetor[0] );
	   }
     else{
        return (  f_soma ( (n-1) , vetor [n-1] ) + vetor[n]  );
	 }
}

int main() {
   
   int vetor [ ] = { 1,2,3,4,5,999, -1};
   int  n = (int) sizeof ( vetor ) ;
   printf("\n A soma dos elementos : %d",  f_soma(n, vetor ));


    return 0;
}

