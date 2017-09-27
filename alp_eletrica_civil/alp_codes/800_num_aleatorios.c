
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
 
int main(void) {
  int c, n, Limite;
 
  printf("\n Quantos números aleatórios inteiros até 10000: ");
  scanf("%d", &Limite);
  printf("%d \n", Limite);
  srand(time(NULL));   // should only be called once
  
  for (c = 1; c <= Limite; c++) {
    n = rand() % 10000 + 1;
    printf("%d ", n);
  }
  printf("\n FIM \n");
  return 0;
}
