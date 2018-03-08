#include <stdio.h> // sao bibliotecas

int main(void)  // AQUI COMECA O ALGORITMO principal
{  // sem ;
  float Nota_1, Nota_2, Media      ; 
  // declarar variaveis
  // LEITURAS DE N1 e N2 
  printf("\nDigite a 1a nota: ")   ;
  scanf("%f", &Nota_1)             ;

  printf("\nDigite a 2a nota: ")   ;
  scanf("%f", &Nota_2)             ;
 
  // CALCULOS
  Media = (Nota_1 + Nota_2) / 2;
   
  if (Media >= 7.0)// se = if >= maior igual
    {
      printf("\n UFA ... passei! ")   ;
    }
   else
   //if (Media < 7.0)
   {
      printf("\n BUA ... volte proximo semestre! ")   ;
    }
   
  printf("\n A media igual a= %0.3f\n", Media);

  return 1 ;
} // fim de ALGORITMO
