#include <stdio.h>
#include <string.h>

int main()
{
   char src[40];
   char dest[100];
  
   memset(dest, '\0', sizeof(dest)); // inicializa dest
   strcpy(src, " curso de ALP na UDESC ...... ");
   strcpy(dest, src);

   printf("Final copied string : %s\n", dest);
   
   return(0);
}
