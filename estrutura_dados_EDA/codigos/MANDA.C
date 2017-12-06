      #include <stdlib.h>
      #include <stdio.h>   

   int manda_num (void)
   {
      srand( 7 );
      /*randomize();  embaralhe... */
      return( rand() % 100 );
   }  

   void conta_freq ( char x[] , char l, int n )
   {
      int i = 0;
      n = 0;
      for (i = 0; x[i] != '\0' ; i++)
      
         if (x[i] == l)
            n++;
   
      return;
   }