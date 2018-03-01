/*
realloc() : Change the size of previously allocated space 
 */
#include <stdio.h>
#include <stdlib.h>

int main()
{
    int *ptr, i , n1, n2;
    printf("\n Entre TAM do array -> N1: ");
    scanf("%d", &n1);
    // Aloca sequencialmente ....
    ptr = (int*) malloc(n1 * sizeof(int));

    printf("Enderecos alocados na memoria: ");
    for(i = 0; i < n1; ++i)
         printf("\n %u\t %d ",ptr + i, *(ptr + i));

    printf("\nUM NOVO (N2) TAMANHO DE ARRAY (>,=,<): ");
    scanf("%d", &n2);
    // Aloca, reaproveitando o inicio do anterior n1
    ptr = (int*) realloc(ptr, n2); // cuidar com cast (int*)
    for(i = 0; i < n2; ++i)
       printf("\n %u\t %d ",ptr + i, *(ptr + i));
    
    printf("\n N1: %d\t N2: %d\n", n1, n2);
         
    return 0;
}
