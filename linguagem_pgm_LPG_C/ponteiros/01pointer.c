#include <stdio.h>

int main ()
{
    /* x is an integer variable. */
    int x = 999;
    
    /* ptr_x is a pointer to an integer variable. */
    
    int * ptr_x;
    ptr_x = & x;
    
    printf (" x = %d\n", x);
    printf (" Quantos BYTES OCUPA x = %d\n", (int)sizeof(x));
    printf (" ptr_x = %p\n" , ptr_x );
    //printf (" ptr_x = %ud\n" ,  ptr_x ),
    //printf (" ptr_x = %010x\n" , ptr_x );
    printf (" Quanto ao conteudo via ptr_x = %d\n  ", * ptr_x);
    printf(" Endereco de x = %p, valor de x = %d\n", &x, x);
    return 0;
}

/*

    printf("%lu\n", unsigned_boo)
    printf("%du\n", unsigned_boo)
    printf("%ud\n", unsigned_boo)
    printf("%ll\n", unsigned_boo)
    printf("%ld\n", unsigned_boo)
    printf("%dl\n", unsigned_boo)
*/


