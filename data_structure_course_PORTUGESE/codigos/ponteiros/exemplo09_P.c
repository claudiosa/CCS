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

     
    printf("\n ================ STACK -- parte superior =========================\n");  
      printf("\n Ends de:\n sum: %p ( ou %ld) \n num: %p ( ou %ld)", &sum, &sum, &num ,&num );
      printf("\n End de PTR:  %p ( ou %ld)",  &ptr , &ptr  );

   printf("\n ============== HEAP -- parte inferior ===========================\n");
	for(int i= 0; i < num ; i++){
     printf("\n End de ptr: %p APONTA -> %p ( ou %ld)",  &(ptr) , (ptr+i), (ptr+i)  );
	}
	
printf("\n =========================================\n");





    free(ptr);
    return 0;
    
    
    
}
