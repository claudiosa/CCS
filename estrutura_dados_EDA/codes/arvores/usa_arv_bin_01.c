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
    int seq;
      const char *vetor[]= {
      "JOINVILLE","PARIS","VENEZA","BRUXELAS",
      "VANCOUVER","LONDRES","MOSCOU","LUXEMBURGO",
      "GLASCOW", "OXFORD","YORK", "AUSTIN",
      "MONTREAL" };
   
   
     /* criar um ponteiro de arvore .... */
      
      BinTreeNode *pt_TREE;
      pt_TREE = NULL; // aqui sim eh necessario ... VAZIA
      
      // DADOS DA APLICACAO
      TreeEntry  Xdados ; //, *pt_X = &Xdados;

      for ( seq = 0 ; seq < 13 ; seq++ )
      {  
// via PONTEIRO        
//     pt_X -> UM_INT = seq;  
//     pt_X -> UM_NOME = vetor[seq];  
// OU        
       strcpy(Xdados.UM_NOME , vetor[seq]);
       Xdados . UMA_CHAVE = seq;
       // RELEMBRANDO strcpy(Copia,Original);
		   pt_TREE = InsertTree_BIN( pt_TREE, Xdados );
       //printf("\n %d : %x : %s", seq, pt_TREE, Xdados.UM_NOME );
      }

    printf("\n SAIDA IN: \n");  
		printInorder( pt_TREE );

    printf("\n SAIDA PRE: \n");  
    printPreorder( pt_TREE );
    
  //  Inorder( TREE );
  //  Postorder( TREE );




    if ( deltree( pt_TREE ) == true)
    printf("\n ARVORE LIBERADA OK \n");  
    else 
    printf("\n ARVORE NAO LIBERADA");  
    
	
return 1;
   }