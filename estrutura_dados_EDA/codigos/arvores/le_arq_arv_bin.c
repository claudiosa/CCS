// veio o endereco do HEADER da arvore
#include "arv_bin.h"
#define ARQUIVO "input_tree.txt"

void limpeza_teclado(void)
{ /* SEQUENCIA SE DER PROBLEMA NO BUFFER *****/
    setbuf( stdin, NULL );
    fflush(stdin);     // limpeza  do BUFFER teclado
    __fpurge(stdin);    // remove 
   
}

int lendo_dados( BIN_TREE ** pt_tree  )
{

  if (  (* pt_tree) == NULL ) // ou X == NULL ?
	{
	    printf("\n Esta funcao é para ser usada UMA SO VEZ !!!!!");
	    //getchar();
    }
    else
    {
	    printf("\n Esta funcao é para vir com NULL");
	    getchar();
        abort();
    }
    
    // de um arquivo
	int n; 
	printf(" DIGITE o NUMERO DE CHAVES ... um INTEIRO: \a");
    limpeza_teclado();
  /*************************************************/
	FILE *pt_INP = fopen(ARQUIVO, "r");
	//scanf(" %d\r", &n); // num entradas
	fscanf(pt_INP, "%d\r", &n); // num entradas
	//printf(" \n N ====> %d \n", n); // num entradas
	DATA_TREE  Xdados ; // se quiser *pt_X = &Xdados;
    // adicionando DADOS a arvore
     
	while(n > 0)
	{
     // DADOS DA APLICACAO
     fscanf(pt_INP,"%s" , Xdados.UM_NOME);// RELEMBRANDO strcpy(Copia,Original);
     //scanf("%s" , Xdados.UM_NOME);// RELEMBRANDO strcpy(Copia,Original);
	 fscanf(pt_INP, " %d\n", &Xdados.UMA_CHAVE);      
     //scanf(" %d\n", &Xdados.UMA_CHAVE);
     // printf("\n LEU : %d :", Xdados . UMA_CHAVE);  
     // printf("\t NOME: %s ", Xdados . UM_NOME);
     // veja os prototipos etc .....
       *pt_tree = InsertTree_ITERATIVO( *pt_tree ,  Xdados );
       n--;
     }  
     
     fclose(pt_INP);
     if ( ! (* pt_tree) ) // ou X == NULL ?
     return 1; // OK
     else
     return 0;  // erro de leitura
	
    }// fim da entrada --- enchendo a ABB
