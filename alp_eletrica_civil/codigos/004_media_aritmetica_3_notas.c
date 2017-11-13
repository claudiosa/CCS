#include <stdio.h>

int main()
{
  float Nota_1, Nota_2, Nota_3, Media;

  printf("Descr.: Este programa calcula a media entre tres notas:\n\n");
  printf("Digite a primeira nota: ");
  scanf("%f", &Nota_1);

  printf("Digite a segunda nota: ");
  scanf("%f", &Nota_2);

  printf("Digite a terceira nota: ");
  scanf("%f", &Nota_3);

  Media = (Nota_1 + Nota_2 + Nota_3) / 3;

  printf("\n\nA media entre as notas digitadas = %.1f\n", Media);

  return(1);
}
