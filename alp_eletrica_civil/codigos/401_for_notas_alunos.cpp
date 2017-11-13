#include <stdio.h>
 
int main (void) {
   float M_total = 0; // variavel para guardar a soma
   float M_aluno, N1, N2, N3;
   int N; // ate N
  // printf(" Digite total de alunos :");
   scanf("%d", &N );
   
   /* do loop execution */
   for(int cont = 0 ; cont < N; cont ++)
   // cont ++  <=> cont = cont + 1
    {
      scanf("%f %f %f", &N1, &N2,&N3); 
      M_aluno = (N1+N2+N3)/3;
      M_total = M_aluno + M_total;
      printf("\n MT:%4.2f \t Ma:%4.2f \t N1:%0.2f \t N2:%0.2f \t N3:%0.2f", M_total, M_aluno, N1,N2,N3);
     };
           M_total = M_total/N; 
   printf("\n Media final: %f \n", M_total);
   return 0;
}
