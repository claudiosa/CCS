#include <stdio.h>

// TEM QUE PROTOTIPAR A FUNCAO CHAMADA ONDE EH USADA

   void alo (void);
   int manda_UM_num(void);
   int mult_10 (int x);
   int conta_freq ( char x[] , char l);

   int main(void)
   
   {
       
      char frase[]= "Isso eh um teste do e";
      int t;
      alo();
      t =  manda_UM_num();
      printf("\n NUM GERADO %d", t) ;
      printf("\n..... enviou um aleatorio") ;
      printf("\n..... %d", mult_10(t) ) ;
      printf("\n..... multiplicou ... por 10..." ) ;
      printf("\n FREQUENCIA %d", conta_freq ( &frase[0] , 'e' ) ) ;
      //getchar();
   
   
   }
