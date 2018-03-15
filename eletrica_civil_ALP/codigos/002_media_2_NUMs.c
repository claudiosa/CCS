#include <stdio.h> // sao bibliotecas

int main(void)  // AQUI COMECA O ALGORITMO principal
{  // sem ;
  float    Nota_1 = 0;
  float    Nota_2;
  float Media      ;
  float NE; 
  // declarar variaveis
  // LEITURAS DE N1 e N2 
  printf("\nDigite a 1a nota: ")   ;
  scanf("%f", &Nota_1)             ;

  printf("\nDigite a 2a nota: ")   ;
  scanf("%f", &Nota_2)             ;
 
  // CALCULOS
  Media = (Nota_1 + Nota_2) / 2;
   
 // if ((Media >= 7.0) == true) // se = if >= maior igual
 //  if ((Media >= 7.0) == !false)   
    if ( Media >= 7.0 )
    {
      printf("\n UFA ... passei! ")   ;
    }
   
   if ( (Media > 1.9) && (Media < 7.0) )
   { // && = E
      NE = (5.0 - (Media * 0.6)) / 0.4;
      printf("\n Voce precisa: %0.3f ", NE)   ;
    }
    else // em caso de falso
   {
    printf("\n BUA ... volte proximo semestre! ")   ;
   }
   
  printf("\n A media igual a = %0.3f\n", Media);

  return 1 ;
} // fim de ALGORITMO
