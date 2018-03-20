#include <stdio.h> // sao bibliotecas

int main(void)  // AQUI COMECA O ALGORITMO principal
{  // sem ;
<<<<<<< HEAD
  float Nota_1;
  float Nota_2;
=======
  float    Nota_1 = 0;
  float    Nota_2;
>>>>>>> 532ebd317f4198a6fca9bb31c61b73a581a7c9f2
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
   
<<<<<<< HEAD
  if (Media >= 7.0)// se = if >= maior igual
=======
 // if ((Media >= 7.0) == true) // se = if >= maior igual
 //  if ((Media >= 7.0) == !false)   
    if ( Media >= 7.0 )
>>>>>>> 532ebd317f4198a6fca9bb31c61b73a581a7c9f2
    {
      printf("\n UFA ... passei! ")   ;
    }
   
<<<<<<< HEAD
   if ((Media > 1.9) && (Media < 7.0))
=======
   if ( (Media > 1.9) && (Media < 7.0) )
>>>>>>> 532ebd317f4198a6fca9bb31c61b73a581a7c9f2
   { // && = E
      NE = (5.0 - (Media * 0.6)) / 0.4;
      printf("\n Voce precisa: %0.3f ", NE)   ;
    }
<<<<<<< HEAD
    else
=======
    else // em caso de falso
>>>>>>> 532ebd317f4198a6fca9bb31c61b73a581a7c9f2
   {
    printf("\n BUA ... volte proximo semestre! ")   ;
   }
   
<<<<<<< HEAD
  printf("\n A media igual a= %0.3f\n", Media);
=======
  printf("\n A media igual a = %0.3f\n", Media);
>>>>>>> 532ebd317f4198a6fca9bb31c61b73a581a7c9f2

  return 1 ;
} // fim de ALGORITMO
