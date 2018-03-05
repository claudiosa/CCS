#include <stdio.h>
#include <stdlib.h>
int main()
{
  int a;
  int *ptr;  // declara um ponteiro -- ptr-- para um inteiro
             // um ponteiro para uma variavel do tipo INTEIRO
  a = 2017;
  ptr = &a;
  system("clear");
  printf("Valor de A: %d\t Endereco de A: %x\n", a, &a);
  printf("Valor de ptr: %d \t Conteudo via ptr: %d\n", ptr, *ptr);
  printf("Endereco de PTR: %x\n", & ptr);
  return 1;
} 
