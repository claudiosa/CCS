#include <stdio.h>
int main()
{
  int a;
  int *ptr;  // declara um ponteiro -- ptr-- para um inteiro
             // um ponteiro para uma variavel do tipo inteiro
  a = 90;
  ptr = &a;
  printf("Valor de A: %d\n", a);
  printf("Valor de ptr: %d \t Conteudo via ptr: %d\n", ptr, *ptr);
  return 1;
} 
