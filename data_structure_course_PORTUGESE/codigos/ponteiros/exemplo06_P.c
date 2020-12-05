#include <stdlib.h>
#include <stdio.h>
// funcao que  retorna via ponteiro
float * f_media(int , int);
int main(void)
{  	
    float resultado;
    float *pt_float;
    
    pt_float = f_media(3,4); 
    resultado = * pt_float; // apenas lendo 
    // onde o ponteiro esta apontando : a funcao
    // system("clear"); ... cuidar ... causou danos ...
    printf("VALORES: %6.2f : %6.2f", *pt_float, resultado );
    printf("\nENDERECOS: %x : %x : %x", pt_float, &pt_float, 
                                        &resultado ); 
    printf("\nENDERECOS: %x ", & f_media ); 
    printf("\n ... Acabou ....\n");
    return 1;
}

//uma atribuicao de conteudo entre ponteiros: float
float * f_media(int a,  int b)
 { 
   float res = (a+b)*0.5; // media 2 valores
   float *pt_aux = & res;
   printf("\nNA FUNCAO: %x : %x\n", pt_aux, &pt_aux );
   return pt_aux;
 }
