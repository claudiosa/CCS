#include <stdio.h>

int main(void)
{
   float nota1, nota2, media;
  scanf("%f %f",&nota1, &nota2);	
   media = (nota1 + nota2) / 2;
   printf("\n Media entre %f e %f = %f", 
          nota1, nota2, media);
   return (1);
}
/*
udesc@lab:~/joao$ g++  media.cpp 
udesc@lab:~/joao$ ./a.out  <  entrada.txt > saida.txt 
$ ./a.out  <  entrada.txt
A media entre 100.555550 e           200.555557 = 150.555557

$ g++  media.cpp -o EXECUTAVEL
udesc@lab:~/joao$ ./EXECUTAVEL  <  entrada.txt

 Media entre 100.555550 e 200.555557 = 150.555557

*/
