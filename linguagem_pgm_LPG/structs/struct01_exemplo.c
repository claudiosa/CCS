#include <stdio.h>

int main(void)
 {

        struct NOME_DE_TIPO
               {
                char nome[30];
                int idade;
                float peso;
				char sexo;
               } ;

        struct NOME_DE_TIPO X = {"Antonio da Silva" ,
			                      39 , 
			                      68.9, 
			                      'm'};
       /* separados por virgula como matrizes... */

      printf("\n Nome : %s :", X . nome);
      printf("\n Sexo : %c :", X . sexo);
      printf("\n Peso : %2.2f :", X . peso);
      printf("\n Idade : %d :", X . idade);
      /*    TROCANDO O VALOR DE SEXO  */
      X.sexo = 'f';
      printf("\n Sexo : %c :", X . sexo);
      //getchar();
      // LOGO:   "." é um operador
}
