

#include <stdio.h>
#include <stdlib.h>
 
int main() {
  int c, n, Limite;
 
  printf("\n Quantos números aleatórios inteiros até 1000: ");
  scanf("%d", &Limite);
  for (c = 1; c <= Limite; c++) {
    n = rand() % 1000 + 1;
    printf("%d ", n);
  }
 
  return 0;
}
