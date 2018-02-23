#include <stdio.h>
   
    int main(void)
    { // inicio de bloco
      int a, b, MAIOR, MENOR;
   
    printf("\n ENTRADA de 2 NUMEROS (separados por espacos): ");
    scanf("%d %d", & a, & b );
    // ESCRITA DE VALORES
    printf(" SAIDA: \n");

    if (  a >= b ) // condicao LOGICA -- then = entao
       {          // INICIO DE BLOCO = {
         MAIOR = a;
         MENOR = b;
        }             // FIM DE BLOCO = }
        else    // CASO CONTRARIO
        {             // INICIO DE BLOCO = {
          MAIOR = b;
          MENOR = a;
        } // FIM DE BLOCO = }
      
    printf("\n MAIOR: %d : MENOR: %d",  MAIOR,   MENOR );
    printf("\n \n Profs. are humans !!!! \n\n");
    return(1);
    }  // FIM DE BLOCO = }
