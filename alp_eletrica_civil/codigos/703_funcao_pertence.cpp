#include <stdio.h>
#include <stdlib.h>

// tipo NOME ( ARGUMENTOS)
bool f1_pertence_x  (int vetor[] , int x , int N) ;

/* *******************************************************************/
int main (void)
{
   
  int x = 7;  
  // vamos criar e ler a matriz0
  int vetor[] = { 3,4,5,6,7,8,9 };
  int N =  (int) sizeof(vetor)/sizeof(int);
    
   if ( f1_pertence_x ( vetor, x  , N ) )
      printf("SIM, o %d pertence ao vetor", x);
   else
       printf("NAO, o %d NAO pertence ao vetor", x);
  
  printf("\n Profs. are humans !!!! \n\n");
  return 0;
}// fim do MAIN
/********************************************************************/
bool f1_pertence_x  (int vetor[] , int x , int N)
//int f1_pertence_x  (int vetor[] , int x )
{
  int i;
  //printf("Length of parameter: %d\n", sizeof(vetor));
  //printf("Uma unidade do vetor: %d\n", sizeof(vetor[0]) );
  // int N =  (int)( sizeof(vetor) / sizeof(vetor[0]) );
  
  bool chave = false;
  for (i = 0; i < N; i++)
  {  //printf(" .|");
	  if( vetor[i] == x )
		 {
			chave = true;
			//printf("\n trocou e saiu da funcao \n");
			return chave ;
		 }	  
   }
    
    return chave;
 }  
    
 /********************************************************************/
