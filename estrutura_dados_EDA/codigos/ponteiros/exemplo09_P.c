/*
calloc() : Allocates space for an array elements, initializes to zero and then returns a pointer to memory
*/

#include <stdio.h>
#include <stdlib.h>

int main()
{
    int num, i, *ptr, sum = 0;

    printf("Entre numero de elementos: ");
    scanf("%d", &num);
    // AQUI EH UM VETOR DE N POSICOES  ... pequena diferenca
    ptr = (int*) calloc(num , sizeof(int));  

    if(ptr == NULL)                     
    {
        printf("\n Erro! Memoria NAO alocada.\n");
        exit(0);
    }

    printf("Lendo o vetor de elementos: ");
    for(i = 0; i < num; ++i)
    {
        scanf("%d", ptr + i);
        sum += *(ptr + i);
    }

    printf("\nSOMA FINAL = %d\n", sum);
    free(ptr);
    return 0;
}
