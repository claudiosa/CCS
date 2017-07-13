#include <stdio.h>
int main ()
{
    //int array[] = { 45, 67, 89 };
     int array[10];
     int i;
     for(i=0 ; i < 10; i++)
     { scanf(" %d", &array[i]);
       // printf(" %d", array[i]);
     }	 
     
     // impressao classica
     for(i=0 ; i < 10; i++)
     printf(" \t %d", array[i]);
     
       
    int * array_ptr;
    array_ptr = array;
    printf(" \n\n first element: %i (%p)", *array_ptr, array_ptr);
    array_ptr++;
    printf(" \n second element: %i (%p)", *array_ptr, array_ptr);
    array_ptr = array_ptr + 1;
    printf(" \n  third element: %i (%p)", *array_ptr, array_ptr);
    printf("\n ultimo: %i \n" , array[9]);
    
    // LOGO ... usando ponteiro para acessar posicoes do ARRAY
    int *NOVO_ptr = array; //jah inicializado
    for(i=0 ; i < 10; i++)
     {   
       printf("\n POSICAO: %d  %d  %d \t END: %p", i, array[i], *(i+NOVO_ptr), (i+NOVO_ptr) );
     }
    
    
    return 0;
}
