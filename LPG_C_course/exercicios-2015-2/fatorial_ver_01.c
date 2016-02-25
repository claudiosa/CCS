#include <stdio.h>

int main(void)
  {
      // DECLARACOES
      int n, fat, temp, i;
     
      //LEITURA
      printf(" DIGITE n: ");
      scanf("%d" , &n );
      printf(" Valor .... n: %d ", n);  
           
      //INICIALIZACOES
      fat = 1;
      temp = 1;
         
      // MIOLO ... O QUE PEDE....
      for(i = 1; i <= n; i++)
      {
         fat = i * temp;
         temp = fat;
       }

    printf("\n O fatorial de %d é  %d\n\n", n, fat);

   }
