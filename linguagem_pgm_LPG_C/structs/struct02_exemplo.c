#include <stdio.h>

int main(void)
 {
        struct tipo_AUX
               {
                char sexo;
                int idade;
               };

        struct tipo_NOVO
               {
                char nome[30];
                struct tipo_AUX  Outra_Var;
                float peso;
               };

        struct tipo_NOVO X = {"Antonio da Silva" , 'm',  39 , 68.9};
       /* separados por virgula como matrizes... */

      printf("\n Nome : %s :", X . nome);
      printf("\n Sexo : %c :", X . Outra_Var . sexo);
      printf("\n Idade: %d :", X . Outra_Var . idade);
      printf("\n Peso : %2.2f :", X . peso);
      getchar();
}
