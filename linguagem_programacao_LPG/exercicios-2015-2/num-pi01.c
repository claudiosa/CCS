#include <stdio.h>
#include <math.h>


int main (void)
{
     float  num_pi = 0; 
     int N = 10, sinal, n;
   // ESTUDO DO SINAL
    /* for(i=0 ; i < N; i++)
     { 
		//sinal =  ((-1)^i);
		// Conversao de tipos = cast
		sinal = (int)pow((-1),i); 
		termo = termo * sinal;
        printf(" %d:%d ", termo, sinal );
     }	 
     */
       
     for(n=1 ; n < N; n++)
     {
     sinal = (int)pow((-1),(n-1)); 
     num_pi = num_pi + (float)(sinal*4)/(2*n-1);
     printf("\n PI parcial: %f ", num_pi );
     }
    
     printf("\n Com 10 termos %f \n : %d",num_pi, n );
  
    return 0;
}
