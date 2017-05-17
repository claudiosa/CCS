// Entrada via ARQUIVO
/*
 * $ ./a.out <  entrada_array_1d.txt
   MUITO UTIL ESTE EXEMPLO 
 */ 
#include <stdio.h>
int main(){
	 int tam_A;
	 scanf("%d", &tam_A);
     int cont_ocorr = 0; 
     int B[] = { 9 , 2, 8, 4, 5};
     int tam_B = (int) (sizeof(B) / sizeof(int));
     
     int A[tam_A];
    // LEITURA DO VETOR 
    for(int i=0; i < tam_A ; i++ ){
	   scanf("%d ", & A [i]);
	   }
	   
	// ESCRITA  DO VETOR 
    for(int i=0; i < tam_A ; i++){
      printf("\t vetor[%d]: %d", i,  A[i]);
      }
     
	for(int i=0; i < tam_A ; i++)
	{
     for(int j=0; j < tam_B ; j++)
     {
       if(A[i] == B[j])
          cont_ocorr++;
      }};
      

/*  CASO ESPECIFICO ... B esta na sequencia
    for(int i=0; i < tam_A ; i++)
	{
       if((A[i] >= 1) && (A[i] <= 5) )
          cont_ocorr++;
    };
*/



     printf("\n\n\n OCORRENCIAS: %d", cont_ocorr);
      

return 0;
}
