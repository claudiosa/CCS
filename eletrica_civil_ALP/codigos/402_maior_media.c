#include <stdio.h>
 
int main (void) {
   int cont	; // Variavel contador SEMPRE DO TIPO INTEIRA
   float M_total = 0; // variavel para guardar a soma das medias de todos alunos
   float M_aluno, N1, N2, N3, Maior_Media = -1;
   int N, N_aluno; // Quantos alunos ou total de alunso N
   //printf(" Digite total de alunos :");
   scanf("%d", &N );// Lendo N
   /* LACO DE LER AS NOTAS E CALCULOS */
  
  for(cont = 0 ; cont < N ; cont ++)//nao colocar ; AQUI
   // cont ++  <=> cont = cont + 1
    {
	 // printf("\nDigite as 3 notas dos alunos separadas por espacos: ");	
      scanf("%f %f %f", &N1, &N2, &N3); // as 3 notas
      M_aluno = (N1 + N2 + N3) / 3;
      if(M_aluno >= Maior_Media )
      {Maior_Media = M_aluno; // ATUALIZEI A MAIOR MEDIA
	   N_aluno = cont + 1; 	  
	   printf("\n TROCOU"); 	  
	  } 	  
      M_total = M_total + M_aluno ;
      
      printf("\n MT:%4.2f \t Maluno:%4.2f \t N1:%0.2f \tN2:%0.2f \tN3:%0.2f", 
              M_total, M_aluno, N1, N2 , N3 );
      
     }; // encerra o laco
           
   M_total = M_total/N; // faz o calculo
   printf("\n Media final: %f \n", M_total);
   printf("\n O aluno %d tem a Maior Media: %f \n", N_aluno, Maior_Media);
   return 0;
}
