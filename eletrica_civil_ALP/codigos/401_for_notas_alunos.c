#include <stdio.h>
 
int main (void) {
   int cont	; // Variavel contador SEMPRE DO TIPO INTEIRA
   float M_total = 0; // variavel para guardar a soma das medias de todos alunos
   float M_aluno, N1, N2, N3;
   int N; // Quantos alunos ou total de alunso N
   //printf(" Digite total de alunos :");
   scanf("%d", &N );// Lendo N
   //printf("\n TOTAL DE ALUNOS: %d", N );// Escrevendo
   
   /* LACO DE LER AS NOTAS E CALCULOS */
   cont = 0 ;
   while(  cont < N )
   //for(cont = 0 ; cont < N ; cont ++)//nao colocar ; AQUI
   // cont ++  <=> cont = cont + 1
    {
	 // printf("\nDigite as 3 notas dos alunos separadas por espacos: ");	
      scanf("%f %f %f", &N1, &N2, &N3); // as 3 notas
      M_aluno = (N1 + N2 + N3) / 3;
      M_total = M_total + M_aluno ;
      printf("\n MT:%4.2f \t Maluno:%4.2f \t N1:%0.2f \tN2:%0.2f \tN3:%0.2f", 
              M_total, M_aluno, N1, N2 , N3 );
      cont = cont + 1;        
     }; // encerra o laco
           
   M_total = M_total/N; // faz o calculo
   printf("\n Media final: %f \n", M_total);
   return 0;
}
