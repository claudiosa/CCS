#include <stdlib.h>
#include <stdio.h>

int main(void)
{  	int matriz [][3] =  {{9, 8, 7},
	                    {99, 88, 77}, 
	                    {1, 2, 3}};
    int *pt_int;
    int count;
    pt_int = &matriz [0][0]; // tem que indicar 
                            // a celula
    for (count=0;count<9;count++)
    {
     printf("%d : ", *pt_int );
     pt_int ++;
    }
   printf("\n ... Acabou ....\n");
   return 1;
}
