#include <stdio.h>

int main(){
  for (int i = 0; i <= 1000000; i++) {
    printf("%iOk\r", i);
  }
  return 0;
}
// gcc main.c && ./a.out