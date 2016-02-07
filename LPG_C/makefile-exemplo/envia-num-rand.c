      #include <stdlib.h>

// ENVIA UM NUMERO ALEATORIO
   int manda_UM_num (void)
   {
      srand( 7 );
      /*randomize();  xxx embaralhe... */
      return( rand() % 100 );
   }  

