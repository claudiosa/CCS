 // Definicao de arv_bin011.h
#include "arv_bin.h"
 /* CreateTree:  create a tree.
Pre:   None.
Post: An empty binary search tree has been created to which root points.
 */
void CreateTree(BinTreeNode **root)
{    // VEM O ENDERECO ....do ponteiro original
	 *root = NULL;
}

// ALOCA UM NO DA ARVORE
BinTreeNode * cria_no_BIN(void)
{
  BinTreeNode *X;
  X =  (BinTreeNode *) malloc (sizeof (BinTreeNode));
  if ( ! X ) // ou X == NULL ?
	{
	    printf("\n problema de alocacao... de memoria");
	    getchar();
     }
   else
    {
	       X -> left = NULL;
	       X -> right = NULL;
    }
      return ( X );
}

/* TreeEmpty:  TRUE if the tree is emtpy.

Pre:   The tree to which root points has been created.
Post: The function returns the value TRUE or FALSE according as the
tree is empty or not.
 */
bool TreeEmtpy(BinTreeNode *root)
{
    if(root == NULL)
	 return true;
     else
     return false;   
}

 /* InsertTree: insert a new node in the tree.
Pre:   The binary search tree to which root points has been created.
	 The parameter newnode points to a node that has been created and
	 contains a key in its entry.
Post: The node newnode has been inserted into the tree in such a way
	 that the properties of a binary search tree are preserved.
 */
// root vira como COPIA
// podes fazer por REFERENCIA **   
BinTreeNode * InsertTree_BIN(BinTreeNode *root, TreeEntry INFO )
{
  if (root == NULL) 
  {
   // cria um no ao chegar numa folha na arvore ... 
   BinTreeNode * X = cria_no_BIN(); 
	 X -> dados . UMA_CHAVE = INFO . UMA_CHAVE; 
   strcpy(X -> dados.UM_NOME , INFO . UM_NOME);
   // Tipo TreeEntry
   //printf("\n %d : %x : %s", X -> dados.UMA_CHAVE , X , X -> dados.UM_NOME );
	 X -> left = X -> right = NULL;
   root = X; // CUIDADO ... NAO ESQUECER
    // TINHA ESQUECIDO DE ATUALIZAR ... 2 horas estudo
    // pois eh o ultimo inserido e a ULTIMA CHAMADA RECURSIVA ....
	 } 
   else 
     {
      if ((INFO.UMA_CHAVE) == (root -> dados.UMA_CHAVE))
        {
          printf("\n CHAVE DUPLICADA !!!"); 
          printf("\n VIOLA DEFINICAO DE ABB !!!\n"); 
          printf("\n TINHA: %d | ENTRY: %d\n",root -> dados.UMA_CHAVE, INFO.UMA_CHAVE ); 
          getchar();
          //system("exit"); // ver isto depois 
        } 
      // SEGUE A BUSCA ATE UMA FOLHA  
       else if ((INFO.UMA_CHAVE) < (root -> dados.UMA_CHAVE))
       root->left = InsertTree_BIN(root->left, INFO); // MENOR: ESQUERDA
       else
       root->right = InsertTree_BIN(root->right, INFO);// MAIOR: DIREITA
   } 

   //printf("\n Retorno da NOVA raiz : %x ", X );
   return root; // falhando em chave duplicada .... todo fluxo passa aqui
}
//======================================================//
// Feito as pressas ... meio longo ... deve ser melhorado
BinTreeNode * InsertTree_ITERATIVO(BinTreeNode *NOH_RAIZ, TreeEntry INFO )
{ // cria um no ao chegar numa folha na arvore ...
   if (NOH_RAIZ == NULL) // UMA UNICA VEZ
  {
   // cria um no ao chegar numa arvore VAZIA
   BinTreeNode * X = cria_no_BIN(); 
	X -> dados . UMA_CHAVE = INFO . UMA_CHAVE; 
    strcpy( X -> dados.UM_NOME , INFO . UM_NOME);
    X -> left  = NULL;  // Aterramentos
	X -> right = NULL;  // Aterramentos
    return X; // serah a raiz pois estava vazia a mesmo
    }
  	
  BinTreeNode * predecessor = NOH_RAIZ;
  BinTreeNode * ancora = NOH_RAIZ; // PODERIA SER USADO um TEMP
  // mas a raiz existente eh a MESMA
  char link_lr; // uma chave Left ou Right  
  while ( NOH_RAIZ!= NULL ) 
     {
      if ( INFO.UMA_CHAVE < (NOH_RAIZ -> dados.UMA_CHAVE) ) 
      {  predecessor = NOH_RAIZ;
		 link_lr = 'l'; 
      // alvo menor que o valor corrente da raiz
         NOH_RAIZ = NOH_RAIZ->left; // AVANCA
       }  
       // alvo MAIOR que o valor corrente da raiz
      else if ( INFO.UMA_CHAVE > (NOH_RAIZ-> dados.UMA_CHAVE) )
         {  predecessor = NOH_RAIZ;
			link_lr = 'r'; 
            NOH_RAIZ = NOH_RAIZ->right;
          }
      else if ( INFO.UMA_CHAVE == (NOH_RAIZ-> dados.UMA_CHAVE) )
         { printf("CHAVE DUPLICADA -- jah esta na arvore");
		   getchar();	 
		   return ancora; 
		  } 
            
     } // fim do while

   // ALOCA E COPIA etc 
   BinTreeNode * X = cria_no_BIN(); 
	X -> dados . UMA_CHAVE = INFO . UMA_CHAVE; 
   strcpy(X -> dados.UM_NOME , INFO . UM_NOME);
   //printf("\n %d : %x : %s", X -> dados.UMA_CHAVE , X , X -> dados.UM_NOME );
   X -> left = X -> right = NULL; // Aterramento
   // CONECTA O NOVO NOH AO PREDECESSOR
   if(link_lr == 'l')
   predecessor -> left = X; // esquerda
   else // 'r'
   predecessor -> right = X; // direita
   
   return ancora; // raiz original mantida
}
//======================================================//
// NUMERO DE NOS -- Faca a versao iterativa
int num_nos_ABB( BinTreeNode *root)
{
  if (root == NULL) 
  return 0;
  
  int qt_left = num_nos_ABB(root ->left); // sub-arv esquerda
  int qt_right = num_nos_ABB(root ->right); // sub-arv direita
  return ( qt_left + 1 + qt_right );

  //return( sizeof_Tree_BIN(root ->left) + 1 +
  //        sizeof_Tree_BIN(root ->right)  );
 }

//======================================================//
// A MAIOR PROFUNDIDADE = ALTURA DE UNO  -- Faca a versao iterativa
int altura_ABB( BinTreeNode *root )
{
  if (root == NULL) 
  return -1;
 
  int A1 = altura_ABB(root ->left);
  int A2 = altura_ABB(root ->right);
  if (A1 > A2)
	return (A1 + 1);
  else
	return (A2 + 1);
  //return ( maior (A1 , A2) + 1 );
 }
//======================================================//

int fator_balanco_ABB( BinTreeNode *root )
{
  if (root == NULL) 
  return -1;
 
  int A1 = altura_ABB(root ->left);
  int A2 = altura_ABB(root ->right);
  return (A1 - A2);
  // SE = 0 ... igual aos 2 lados
  // SE > 0 ... lado esquerdo eh MAIOR
  // SE < 0 ... lado direito eh MAIOR
  
 }
//======================================================//
int maior (int x, int y)
 {
	 if(x > y)
	 return x;
	 else
	 return y;
}
// ==================================================== //

 /* TreeSearch: search for target starting at node root.
Pre:   The tree to which root points has been created.
Post: The function returns a pointer to a tree node that matches target
or NULL if the target is not in the tree.
 */

BinTreeNode *TreeSearch(BinTreeNode *NOH_RAIZ, int ALVO)
{
   if ( NOH_RAIZ != NULL )
   {
     // RAMO ESQUERDO
     if ( ALVO < (NOH_RAIZ -> dados.UMA_CHAVE) ) 
      // alvo menor que o valor corrente da raiz
      NOH_RAIZ = TreeSearch(NOH_RAIZ->left, ALVO);
     
     if ( ALVO > (NOH_RAIZ-> dados.UMA_CHAVE) )
        NOH_RAIZ = TreeSearch(NOH_RAIZ->right, ALVO);
     
     if ( ALVO == (NOH_RAIZ-> dados.UMA_CHAVE) ) // achou!!!
        return NOH_RAIZ; 
     else  
     {
      printf("\n ALGUM Problema em TreeSearch : ALVO era: %d", ALVO); 
      getchar();
     // system("exit"); // ver isto depois 
     } 
     
    } // FIM DO IF 
   // se nao foi chamada para o lado esquerdo ou direito
   // NEM eh o valor ALVO procurado ou raiz NULL ... ENTAO valor
   // nao estah na arvore   
   return NOH_RAIZ;
}
// ==================================================== //
// VERSAO NAO RECURSIVA
BinTreeNode *TreeSearch_ITERATIVO(BinTreeNode *NOH_RAIZ, int ALVO)
{
  while ( ALVO != (NOH_RAIZ-> dados.UMA_CHAVE) ) // NAO achou!!! 
      {
       if ( ALVO < (NOH_RAIZ -> dados.UMA_CHAVE) ) 
      // alvo menor que o valor corrente da raiz
         NOH_RAIZ = NOH_RAIZ->left;
       // alvo MAIOR que o valor corrente da raiz
         else if ( ALVO > (NOH_RAIZ-> dados.UMA_CHAVE) )
         NOH_RAIZ = NOH_RAIZ->right;
     
       } // fim do while

      if ( ALVO == (NOH_RAIZ-> dados.UMA_CHAVE) ) // achou!!!
        return NOH_RAIZ; 
     
      else if ( NOH_RAIZ == NULL ) 
      {
      printf("\n ARVORE VAZIA ...."); 
      getchar();
     // system("exit"); // ver isto depois 
      } 
     else  
     {
      printf("\n ALGUM Problema em TreeSearch : ALVO era: %d", ALVO); 
      getchar();
     // system("exit"); // ver isto depois 
     } 
     return NOH_RAIZ;
}

// ==================================================== //

// ESTA quase BOM .... usando o outro por **
int deltree(BinTreeNode * tree) 
{
   if (tree == NULL) 
   return 0; // true; 
   
   deltree(tree->left);
   deltree(tree->right);
   // EXCLUIR O NOH CORRENTE APOS EXCLUIR AS SUB-ARVORES
   
   free(tree); // libera o ESPACO ... apenas isto
   tree = NULL; //  e aqui faz efetivamente ir para o VAZIO
   if (tree == NULL) 
   printf("\n noh liberado");
   else
   {
   printf("\n noh NAO liberado");
   print_NODE(tree);
   }
   return 1; // true; 
 
 }

// ==================================================== // 
//**********************************  */   
// ESTA quase BOM ....
int deltree_TRUE(BinTreeNode ** tree) 
{
if ((*tree) == NULL) 
   return 0; // true; 

   deltree_TRUE(&(*tree)->left);
   deltree_TRUE(&(*tree)->right);
   // EXCLUIR O NOH CORRENTE APOS EXCLUIR AS SUB-ARVORES
   
   free( (*tree) ); // libera folha ou espaco
   (*tree) = NULL; // efetivamente redireciona o ponteiro
   // talvez C++ ou compilador moderno ... torne isto em NULL 
   return 1; // true; 
 }
// ==================================================== //
// 
void print_NODE(BinTreeNode * node)
{
     /* print the data of node */
     printf("\n End: %d ", node); //%x
     printf("\t CHAVE: %d :", node->dados . UMA_CHAVE);  
     printf("\t NOME: %s ", node->dados . UM_NOME);
     return;
}
// ==================================================== //
void printInorder(BinTreeNode * node)
{
   if (node == NULL)
      return;

     /* VISITE A SUB ARVORE A ESQUERDA */
     printInorder(node->left);
     /* then print the data of node */
     printf("\n: %d :", node->dados . UMA_CHAVE);  
     printf("\t NOME: %s ", node->dados . UM_NOME);
     //printf("\t END NOH: %x ",  node );  
     /* now VISITE A SUB ARVORE A DIREITA */
     printInorder(node->right);
}
// ==================================================== //
 /* Preorder: visit each node of the tree in preorder.
Pre:  The binary tree to which root points has been created.
Post: The function Visit has been performed on every entry in the binary
tree in preorder sequence.
 */

// IMPRIMA SUB a esquerda e SUB a direita
void printPreorder(BinTreeNode * node)
{
  if (node == NULL)
      return;
     /* first print the data of node */
     printf("\n: %d :", node->dados . UMA_CHAVE);  
     printf("\t NOME: %s ", node->dados . UM_NOME);  
     /*  then recur on left child */
     printPreorder(node->left);
     /* now recur on right child */
     printPreorder(node->right);
}

// ==================================================== //
void printPosorder(BinTreeNode * node)
{
  if (node == NULL)
      return;
     /* first recur on left child */
     printPosorder(node->left);
     /* then recur on right child */
     printPosorder(node->right);
     /* now print the data of node */
     printf("\n: %d :", node->dados . UMA_CHAVE);  
     printf("\t NOME: %s ", node->dados . UM_NOME);  
}
/* ***********************************************/


