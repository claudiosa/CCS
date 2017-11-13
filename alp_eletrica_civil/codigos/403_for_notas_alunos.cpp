
#include <stdio.h>
 
int main (void) {
   float M_total = 0; // variavel para guardar a soma
   float M_aluno, N1, N2, N3;
   float Maior_Media; // notas de 0 a 10
   float Menor_Media;
   int pos_MAIOR, pos_MENOR;
   
   
   int N; // ate N
  // printf(" Digite total de alunos :");
   scanf("%d", &N );
   
   scanf("%f %f %f", &N1, &N2,&N3); // LEITURA
   M_aluno = (N1+N2+N3)/3;
   pos_MAIOR = pos_MENOR = 1;
   Maior_Media = Menor_Media = M_aluno;
   M_total = M_aluno ; 
      
   /* do loop execution */
   for(int cont = 2 ; cont <= N; cont ++)
   // cont ++  <=> cont = cont + 1
    {
      scanf("%f %f %f", &N1, &N2,&N3); // LEITURA
      M_aluno = (N1+N2+N3)/3;
      // COLOQUE IFs aqui ... para trocar a maior e menor NOTA
      if( M_aluno > Maior_Media  )
      {   printf("\t TROCOU O MAIOR ...\n");
		  // printf("\t Maior media ate entao era: %0.2f \n", Maior_Media);
		  // printf("\t SERA TROCADA POR: %0.2f \n", M_aluno);
		  Maior_Media = M_aluno;
		  pos_MAIOR = cont;
	   }	  
		  
      if( M_aluno < Menor_Media  )
      {   printf("\t TROCOU A MENOR ...\n");
		  // printf("\t Menor media ate entao era: %0.2f \n", Menor_Media);
		  // printf("\t SERA TROCADA POR: %0.2f \n", M_aluno);
		  Menor_Media = M_aluno;
		  pos_MENOR = cont;
	   }	  
		
      
      M_total = M_aluno + M_total; 
    printf("\n MT:%4.2f \t Ma (%d):%4.2f \t N1:%0.2f \t N2:%0.2f \t N3:%0.2f", 
    M_total, cont, M_aluno, N1,N2,N3);
     }; // fim do FOR
     
     
     
   M_total = M_total/N; 
   printf("\n Media final: %f \n", M_total);
   
   printf("\n MAIOR MEDIA: %0.2f (%d)\n",
    Maior_Media, pos_MAIOR );
   printf("\n MENOR MEDIA: %0.2f (%d) \n", 
    Menor_Media , pos_MENOR );
   
   
   
   return 0;
}
