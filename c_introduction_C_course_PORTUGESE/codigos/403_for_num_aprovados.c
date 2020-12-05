#include <stdio.h>

int main (void) {
  int cont	; // Variavel contador SEMPRE DO TIPO INTEIRA
  float M_total = 0; // variavel para guardar a soma das medias de todos alunos
  float M_aluno, N1, N2, N3;
  int N, N_aprovados, N_exames, N_regulares ; // Variaveis diversas
  N_aprovados = N_exames = N_regulares = 0 ; // Inicializando-as
  //printf(" Digite total de alunos :");
  scanf("%d", &N );// Lendo N
  /* LACO DE LER AS NOTAS E CALCULOS */
  for(cont = 0 ; cont < N ; cont ++)//NUNCA colocar ; AQUI
  // cont ++  <=> cont = cont + 1
  {
    // printf("\nDigite as 3 notas dos alunos separadas por espacos: ");
      scanf("%f %f %f", &N1, &N2, &N3); // as 3 notas
      M_aluno = (N1 + N2 + N3) / 3;

      if( M_aluno >= 7.0 )
      {printf("\n ALUNO APROVADO" );
      N_aprovados = N_aprovados + 1;
      } // FINAL DO IF
      else
      {
      N_exames = N_exames + 1;
      printf("\n ALUNO EM EXAME" );
      } // FINAL DO IF

    if((N1 == N2) && (N3 == N2) )
    {
      printf("\n >>>>> ALUNO REGULAR <<<<<<< " );
      N_regulares = N_regulares + 1;
    } // FINAL DO IF

    M_total = M_total + M_aluno ;
    printf("\n %d: MT:%4.2f \t Maluno:%4.2f \t N1:%0.2f \tN2:%0.2f \tN3:%0.2f " , (cont+1), M_total, M_aluno, N1, N2 , N3 );

}; // encerra o laco FOR
    M_total = M_total/N; // faz o calculo
    printf("\n Média final da turma: %0.3f \n", M_total );
    printf("\n Alunos REGULARES: %d", N_regulares );
    printf("\n Alunos APROVADOS: %d", N_aprovados );
    printf("\n Alunos em EXAME: %d\n\n\n", N_exames );
    return 0;
}
