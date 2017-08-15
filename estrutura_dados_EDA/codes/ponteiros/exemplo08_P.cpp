/*
malloc() : Allocates requested size of bytes and returns a pointer first byte of allocated space
calloc() : Allocates space for an array elements, initializes to zero and then returns a pointer to memory
free(): deallocate the previously allocated space
realloc() : Change the size of previously allocated space 
 */
#include <stdio.h>
#include <stdlib.h>

int main()
{
    int num, i, *ptr, sum = 0;

    printf("Entre numero de elementos: ");
    scanf("%d", &num);

    ptr = (int*) malloc(num * sizeof(int));  
    //memoria alocada usando malloc
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
