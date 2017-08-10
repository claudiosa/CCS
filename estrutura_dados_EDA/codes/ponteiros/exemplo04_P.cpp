#include <stdlib.h>
#include <stdio.h>

int main(void)
{  	
	float matriz [50][50];
    float *pt_float;
    int count;
    pt_float = matriz[0];
    for (count=0;count<2500;count++)
    {
     *pt_float = 0.0;
     pt_float ++;
    }
   printf("\n ... Acabou ....\n");
   return 1;
}
