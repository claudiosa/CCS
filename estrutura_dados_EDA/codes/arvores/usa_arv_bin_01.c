 // Definicao de arv_bin011.h
#include "arv_bin.h"

/*
   void CreateTree(arv_bin **root);
   arv_bin * InsertTree(arv_bin * X, char * Y, int Z);
   void DeleteNodeTree( arv_bin **p );
   arv_bin * TreeSearch(arv_bin *root, char * target)  ;
   void Inorder(arv_bin * X );
   void Preorder(arv_bin * X ) ;
	void Postorder(arv_bin * root );
	arv_bin * Del_No_2( arv_bin * raiz, char * X );

*/

int main(void)
   {
      system("clear");
    
      const char *vetor[]= {
      "JOINVILLE","PARIS","VENEZA","BRUXELAS",
      "VANCOUVER","LONDRES","MOSCOU","LUXEMBURGO",
      "GLASCOW", "OXFORD","YORK", "AUSTIN",
      "MONTREAL" };
   
      /* criar um ponteiro de arvore .... */
      BinTreeNode *pt_TREE;
      pt_TREE = NULL; // aqui sim  interessante ... VAZIA
      
      // DADOS DA APLICACAO
      TreeEntry  Xdados ; // se quiser *pt_X = &Xdados;

      for (int seq = 0 ; seq < 5 ; seq++ )
      {  
// use dados via PONTEIRO        
//     pt_X -> UM_INT = seq;  
//     pt_X -> UM_NOME = vetor[seq];  
// OU diretamente       
       strcpy(Xdados.UM_NOME , vetor[seq]);
       Xdados . UMA_CHAVE = rand()%100; // NUM aleatorio mesmo
       // RELEMBRANDO strcpy(Copia,Original);
		   pt_TREE = InsertTree_BIN( pt_TREE, Xdados );
       //printf("\n %d : %x : %s", seq, pt_TREE, Xdados.UM_NOME );
       printf(":%d : %d : %s (End: %x) \t", seq, Xdados.UMA_CHAVE, Xdados.UM_NOME, pt_TREE );
      }

      // UMA BUSCA
      BinTreeNode *consulta;
      int ALVO;
    
      printf("\n Qual dado alvo: ");
      scanf("%d", &ALVO);
      //printf("\n ALVO: %d", ALVO);
      consulta = TreeSearch(pt_TREE, ALVO);
      if(consulta == NULL)
      printf("\n NAO HA TAL ALVO OU CHAVE \n");
      else
      printf("\n Resposta:  %d : %s : END: %x  ",  
        consulta -> dados.UMA_CHAVE, consulta-> dados.UM_NOME,
        consulta );  
   

    printf("\n SAIDA IN: \n");  
    printInorder( pt_TREE );

/*
    printf("\n SAIDA PRE: \n");  
    printPreorder( pt_TREE );
    
    printf("\n SAIDA POS: \n");  
    printPosorder( pt_TREE );
 */   


    if ( deltree( pt_TREE ) == true)
    printf("\n ARVORE LIBERADA OK \n");  
    else 
    printf("\n ARVORE NAO LIBERADA");  
    
	
return 1;
   }