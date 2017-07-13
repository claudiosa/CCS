#include <stdio.h>

int main(void)
 {
        struct NOME_DE_TIPO
               {
                char nome[30];
                int idade;
                float peso;
				char sexo;
               };

     struct NOME_DE_TIPO X[1] = 
	  {
	   {"Antonio da Silva" , 39 , 68.9, 'm'},
	   {"Antonia de Souza" , 29 , 48.9, 'f'}
	  };
       /* separados por virgula como matrizes... */

      printf("\n Nome : %s :", X[0] . nome);
      printf("\n Sexo : %c :", X[0] . sexo);
      printf("\n Peso : %2.2f :", X[0] . peso);
      printf("\n Idade : %d :", X[0] . idade);

      printf("\n\n Nome : %s :", X[1] . nome);
      printf("\n Sexo : %c :", X[1] . sexo);
      printf("\n Peso : %2.2f :", X[1] . peso);
      printf("\n Idade : %d :", X[1] . idade);

      //getchar();
      // LOGO:   "." é um operador
      return 1;
}
