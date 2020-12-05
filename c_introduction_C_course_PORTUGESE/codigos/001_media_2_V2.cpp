#include <stdio.h> // BIBLIOTECA de FUNCOES

int main( )
{ 
   float N_1, N_2, Med; // DECLARACAO de VARIAVEIS
   printf("\n DIGITE AS DUAS NOTAS: "); 
   //scanf("%f", & N_1)    ;
   //scanf(" %f", & N_2)   ;
   // LEITURA DE VALORES
   scanf("%f  %f",& N_1 , & N_2 );
   printf("\n GARANTIA: %f : %f\n", N_1, N_2);
   // CALCULO
   Med = (N_1 + N_2) / 2;
   // IMPRIMIR A SAIDA
   printf("\n Med entre (%f+%f)/2 = %f\n",
          N_1, N_2, Med);
  // TERMINO COM SUCESSO
   return 1; // FIM
  // ISTO EH UM COMENTARIO
}
