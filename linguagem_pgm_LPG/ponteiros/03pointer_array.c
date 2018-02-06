#include <stdio.h>

int main()
{
    int array[3] = {45, 67, 89};
    printf ("Conteudo: %d END: %p\n", array[0], array);
    printf ("Conteudo: %d END: %p\n", array[0], & array);
    printf ("Conteudo: %d END: %p\n", array[0], & array[0]);
    
    
    // IMPRIMINDO UM ARRAY COM PONTEIRO
    char array_2[] = "Aula de LPG2";
    char *pt_array = array_2; 
    printf ("%s\n", array_2);
    
    int i;
      
   // for(i=0; array_2[i] != '\0'; i++ )   OU
    for(i=0; *(i+pt_array) != '\0'; i++ )
       printf ("%c ", *(i+pt_array) ) ;
    // printf ("%p\n", & array[0]);
    
    printf ("\n=========================== \n");
    return 0;
}
