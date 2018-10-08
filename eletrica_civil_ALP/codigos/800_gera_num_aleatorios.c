
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
 
int main(void) {
  int c, n, qt, limite;
 
  printf("\n Quantos números aleatórios inteiros ?: ");
  scanf("%d", &qt );
  
  printf("Qual limite superior: ");
  scanf("%d", &limite);
  printf("%d \n", limite);
  
  srand(time(NULL));   // should only be called once
  printf("\n =============> INICIO AQUI ... procure o FIM <============== \n");
  printf("%d \n", qt );
  for (c = 1; c <= qt; c++) {
    n = rand() % limite + 1;
    printf("\n%d", n);
  }
  printf("\n =============> FIM <============== \n");
  return 0;
}
