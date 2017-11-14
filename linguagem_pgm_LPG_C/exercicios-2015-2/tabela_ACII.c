#include <stdio.h>
#include <math.h>
//EM MATH TEM ISTO #define M_PI 3.14159265358979323846

int main (void)
{    
     int   n = 1, cont=0;
     
        
     for(; n<256 ; n++)
     {   
      printf("%d:%c \t", n ,n );
      if(cont > 10)
       {
		   printf("\n");
		   cont=0;
		}
		else
		{
			cont= cont+1;
		 }	   
     
    }
   // printf("\n%d:%c \t", 13 , 13 );
    return 0;
}
