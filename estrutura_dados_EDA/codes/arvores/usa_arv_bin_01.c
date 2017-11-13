 // Definicao de arv_bin011.h
#include "arv_bin.h"
#define K 7

int main(void)
   {
      system("clear");
    
      const char *vetor[]= {
      "TOKIO","PARIS","VENEZA","BRUGES",
      "MACAU","LONDRES","MOSCOU","MUNIQUE",
      "GLASCOW", "OXFORD","YORK", "AULNAT",
      "MONTREAL" }; // 13 cidades
      const int chaves[] = {30, 20, 40, 10,
                            //13, 17, 23, 33, // testes de duplicatas
                            25, 35, 50, 31,
                            37, 87, 47, 79, 90}; // 13 chaves
       // ver figura do prof
      /* criar um ponteiro de arvore .... */
      BinTreeNode *pt_TREE;
      pt_TREE = NULL; // aqui sim  interessante ... VAZIA
      
      // DADOS DA APLICACAO
      TreeEntry  Xdados ; // se quiser *pt_X = &Xdados;
      // adicionando DADOS a arvore
      int seq;
      for (seq = 0 ; seq < K ; seq++ )
      {  
// uso dados via PONTEIRO        
//     pt_X -> UM_INT = seq;  
//     pt_X -> UM_NOME = vetor[seq];  
// OU diretamente       
       strcpy(Xdados.UM_NOME , vetor[seq]);// RELEMBRANDO strcpy(Copia,Original);
       Xdados.UMA_CHAVE = chaves[seq];
       // Xdados . UMA_CHAVE = rand()%100; // NUM aleatorio mesmo
       pt_TREE = InsertTree_BIN( pt_TREE, Xdados );
       
       printf("\n INSERINDO :%d : %d : %s (End: %x) \t", seq, Xdados.UMA_CHAVE, Xdados.UM_NOME, pt_TREE );
       printf("\n Agora a altura corrente  eh: %d :", altura_Tree_BIN(  pt_TREE) ); 
       
      }// fim da entrada

      // UMA BUSCA
      BinTreeNode *consulta;
      //int ALVO;
      //printf("\n Qual dado alvo: ");
      //scanf("%d", &ALVO);
      //printf("\t lido ALVO: %d", ALVO);
/*    OK
      for (seq = 0 ; seq < K ; seq++ ) // automatizando
      {  
      //consulta = TreeSearch(pt_TREE, chaves[seq]); // OU
      consulta = TreeSearch_ITERATIVO(pt_TREE, chaves[seq]);
      if(consulta == NULL)
      printf("\n NAO HA TAL ALVO -- CHAVE NA ABB \n");
      else
      printf("\n Resposta:  %d : %s : END: %x  ",  
        consulta -> dados.UMA_CHAVE, consulta-> dados.UM_NOME,
        consulta );  
      }
  */  
    printf("\n NUMERO DE NOSH: %d", sizeof_Tree_BIN( pt_TREE) ); 
    getchar();

    printf("\n SAIDA PRE: \n");  
    printPreorder( pt_TREE );
    getchar();
    printf("\n SAIDA IN: \n");  
    printInorder( pt_TREE );
    getchar();
    printf("\n SAIDA POS: \n");  
    printPosorder( pt_TREE );
    
/* 
if ( deltree( pt_TREE ) == true)
    printf("\n ARVORE LIBERADA OK \n");  
    else 
    printf("\n ARVORE NAO LIBERADA");  
    
 */   

    //deltree( pt_TREE );
    deltree_TRUE( &pt_TREE );
    //pt_TREE  = NULL;  
    printf("\n NUMERO DE NOSH: %d\n", sizeof_Tree_BIN( pt_TREE) ); 
	
return 1;
   }
