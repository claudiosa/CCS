#include <stdio.h>
 
int main (void) {
   float M_total = 0; // variavel para guardar a soma
   float M_aluno, N1, N2, N3;
   float Maior_Media = -1; // notas de 0 a 10
   float Menor_Media = 11;
   
   int N; // ate N
  // printf(" Digite total de alunos :");
   scanf("%d", &N );
   
   /* do loop execution */
   for(int cont = 0 ; cont < N; cont ++)
   // cont ++  <=> cont = cont + 1
    {
      scanf("%f %f %f", &N1, &N2,&N3); 
      M_aluno = (N1+N2+N3)/3;
      // COLOQUE IFs aqui ... para trocar a maior e menor NOTA
      if( M_aluno > Maior_Media  )
      {   printf("\t TROCOU O MAIOR ...\n");
		  printf("\t Maior media ate entao era: %0.2f \n", Maior_Media);
		  printf("\t SERA TROCADA POR: %0.2f \n", M_aluno);
		  Maior_Media = M_aluno;
	   }	  
		  
      if( M_aluno < Menor_Media  )
      {   printf("\t TROCOU A MENOR ...\n");
		  printf("\t Menor media ate entao era: %0.2f \n", Menor_Media);
		  printf("\t SERA TROCADA POR: %0.2f \n", M_aluno);
		  Menor_Media = M_aluno;
	   }	  
		
      
      M_total = M_aluno + M_total;
      printf("\n MT:%4.2f \t Ma:%4.2f \t N1:%0.2f \t N2:%0.2f \t N3:%0.2f", M_total, M_aluno, N1,N2,N3);
     };
           M_total = M_total/N; 
   printf("\n Media final: %f \n", M_total);
   
   printf("\n MAIOR MEDIA: %0.2f \n", Maior_Media );
   printf("\n MENOR MEDIA: %0.2f \n", Menor_Media );
   
   
   
   return 0;
}
