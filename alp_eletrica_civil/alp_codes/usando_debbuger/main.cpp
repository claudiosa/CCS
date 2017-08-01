#include <stdio.h>

int main(void)
{
   float nota1, nota2, media;
   printf("\n DIGITE AS DUAS NOTAS: ");
   scanf("%f %f",&nota1 , &nota2);
   media = (nota1 + nota2) / 2;
   printf("\n Media entre %f e %f = %f",
          nota1, nota2, media);
   return (1); // FIM
}
