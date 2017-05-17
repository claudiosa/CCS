#include <stdio.h>
#include <stdlib.h>

// tipo NOME ( ARGUMENTOS: vetor, elemento, quantas_celulas )
bool f1_pertence_x  (int vetor[], int x, int N) ;

bool f2_pertence_x  (int vetor[] , int x );//  futuro
/* *******************************************************************/
int main (void)
{
  // aqui depois pode ser leitura escrita como visto em outros exemplos	
  int A[] = { 3,4,5,6,7,8,9 };
  int N =  (int) sizeof(A)/sizeof(A[0]);
  int B[] = { 3, 777, 8, 999};
  int M =  (int) sizeof(B)/sizeof(B[0]);
  
  // Quantos IGUAIS nos dois conjuntos ?  ==> tamanho da intersecao
  int iguais = 0;
  for (int i = 0; i < N; i++)
  { for (int j = 0; j < M; j++)
       { if( A[i] == B[j] )
		 {
		  iguais++; 
		  // OU iguais = iguais + 1;
          // OU iguais += 1;   			
		 }
		} 
  }		 
  printf("\n UTIL DEPOIS ... NUM IGUAIS %d ", iguais);
  
  int K = (M+N)-iguais; // faca figura e comprove
  int Uniao[K];
  printf("\n K %d \n", K);
 
  //UNIAO
  // 1. COPIAR A ou B para C
  // 2. TESTAR B ou A contra C
  // 3. INSERE os nao-repetidos (pertence = falso)
  
  // COPIANDO A em UNIAO
  for (int i = 0; i < N; i++)
  Uniao[i] = A[i];
 
 //TESTAR B contra C ...
 int aux = 0; 
 for (int j = 0; j < M; j++)
  {
   if(f1_pertence_x(Uniao , B[j], N) == false)
  // if(f2_pertence_x(Uniao , B[j]) == false)
   {// INSERE ... pois B[j] nao esta em U
    //printf("\t %d  : %d" , K , B[j]); 
     Uniao[N + aux] = B[j]; // COPIA AO FINAL DE Uniao
     aux++; 
   } 
  }   
   
  // IMPRIMI A UNIAO
  for (int i = 0; i < K; i++)
  printf(" |--> %d" , Uniao[i]);
  
  //  
  // FAZER INTERSECAO
  // 0. CRIAR VETOR INTERSECAO ()
  int Inter[iguais]; // quantos comuns ... ja calculados
   // faca figura e comprove
  // 1. COMPARAR A com  B 
  // 2. INSERE os repetidos (pertence = true)
  
  
  
  
  
  
  // FAZER As diferencas
  // DIFERENCA: (A-B)  e (B-A) 
  // Compara A contra B 
  // se estiver em A e nao estiver em B ... insere
  // idem no item anterior
  int dif_AB[N-iguais]; //O num da diferenca A-B eh no maximo tam A
  int dif_BA[M-iguais]; // idem para B-A
  int tam_AB =  (int) (sizeof(dif_AB) / sizeof(dif_AB[0]));
  int tam_BA =  (int) (sizeof(dif_BA) / sizeof(dif_BA[0]));
  // faca figura e comprove 
  
  
  
  
  
  
  // DIFERENCA SIMETRICA = (A-B) Uniao (B-A)
  int dif_SIM[(N-iguais) + (M-iguais)]; //
  int tam_SIM =  (int) (sizeof(dif_SIM) / sizeof(dif_SIM[0]));
  // REPETE o PROCEDIMENTO DA UNIAO A e B visto a acima  
  
  
  
  
  
  printf("\n Profs. are humans !!!! \n\n");
  return 0;
}// fim do MAIN
/********************************************************************/
bool f1_pertence_x  (int vetor[] , int x , int N)
{
  bool chave = false;
  for (int i = 0; i < N; i++)
  {  //printf(" .|");
	  if( vetor[i] == x )
		 {
		  chave = true;
		  //printf("\n trocou e saiu da funcao \n");
		  return chave ;
		 }	  
   }
   return chave; // falso se x nao esta no vetor
 } // fim da funcao  


// PARA O FUTURO
bool f2_pertence_x  (int vetor[ ] , int x )
{   
  int N ; // =  (int) (sizeof(vetor)/sizeof(vetor[0]));
  printf("obter o tamanho de vetor .|%d", N);
  bool chave = false;
  for (int i = 0; i < N; i++)
  {  //printf(" .|");
	  if( vetor[i] == x )
		 {
		  chave = true;
		  printf("\n trocou e saiu da funcao \n");
		  return chave ;
		 }	  
   }
   return chave;
 } // fim da funcao  
    
 /********************************************************************/
