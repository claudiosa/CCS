#include <stdio.h>

   void alo (void);
   int manda_num (void);
   int mult_10 (int x);
   void conta_freq ( char x[] , char l, int & );

   int main(void)
   
   {
   
      /*int i=4;
      printf("ALTERADO....ISTO EH UM TESTE IMPORTANTE");
      i++;
      printf("\n..... %d", i) ;
      getchar();
      */
      char frase[]= "isso eh um teste do e";
      int t;
      alo();
      printf("\n..... %d", manda_num()) ;
      printf("\n..... enviou um aleatorio") ;
      printf("\n..... %d", mult_10(314)) ;
      printf("\n..... multiplicou ... por 10..." ) ;
      conta_freq ( &frase[0] , 'e' , t );
      getchar();
   
   
   }
