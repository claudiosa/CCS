
#include "arv_bin.h"
 /* CreateTree:  create a tree.
Pre:   None.
Post: An empty binary search tree has been created to which root points.
 */
void CreateTree(BIN_TREE **root)
{    // VEM O ENDERECO ....do ponteiro original
	 *root = NULL;
}

<<<<<<< HEAD
// ALOCA UM NO NA ARVORE
=======
// ALOCA UM NO DA ARVORE
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
BIN_TREE * cria_no_BIN(void)
{
  BIN_TREE *X;
  X =  (BIN_TREE *) malloc (sizeof (BIN_TREE));
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
	 // nao foi adicionado o CONTEUDO no NO
   return ( X );
}

/* TreeEmpty:  TRUE if the tree is emtpy.
Pre:   The tree to which root points has been created.
Post: The function returns the value TRUE or FALSE according as the
tree is empty or not.
 */
bool TreeEmtpy(BIN_TREE *root)
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
<<<<<<< HEAD
// podes fazer por REFERENCIA **
=======
// podes fazer por REFERENCIA **   
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
BIN_TREE * InsertTree_BIN(BIN_TREE *root, DATA_TREE INFO )
{
  if (root == NULL)
  {
<<<<<<< HEAD
   // cria um no ao chegar numa folha na arvore ...
   BIN_TREE * X = cria_no_BIN();
	 X ->  UMA_CHAVE = INFO . UMA_CHAVE;
   strcpy(X -> UM_NOME , INFO . UM_NOME);
   // Tipo DATA_TREE
   //printf("\n %d : %x : %s", X -> UMA_CHAVE , X , X -> UM_NOME );
  	X -> left = X -> right = NULL;
=======
   // cria um no ao chegar numa folha na arvore ... 
   BIN_TREE * X = cria_no_BIN(); 
	 X ->  UMA_CHAVE = INFO . UMA_CHAVE; 
   strcpy(X -> UM_NOME , INFO . UM_NOME);
   // Tipo DATA_TREE
   //printf("\n %d : %x : %s", X -> UMA_CHAVE , X , X -> UM_NOME );
	X -> left = X -> right = NULL;
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
    root = X; // CUIDADO ... NAO ESQUECER
    // TINHA ESQUECIDO DE ATUALIZAR ... 2 horas estudo
    // pois eh o ultimo inserido e a ULTIMA CHAMADA RECURSIVA ....
	 }
   else
     {
      if ((INFO.UMA_CHAVE) == (root -> UMA_CHAVE))
        {
<<<<<<< HEAD
          printf("\n CHAVE DUPLICADA !!!");
          printf("\n VIOLA DEFINICAO DE ABB !!!\n");
          printf("\n TINHA: %d | ENTRY: %d\n",root -> UMA_CHAVE, INFO.UMA_CHAVE );
          getchar();
          //system("exit"); // ver isto depois
        }
      // SEGUE A BUSCA ATE UMA FOLHA
=======
          printf("\n CHAVE DUPLICADA !!!"); 
          printf("\n VIOLA DEFINICAO DE ABB !!!\n"); 
          printf("\n TINHA: %d | ENTRY: %d\n",root -> UMA_CHAVE, INFO.UMA_CHAVE ); 
          getchar();
          //system("exit"); // ver isto depois 
        } 
      // SEGUE A BUSCA ATE UMA FOLHA  
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
       else if ((INFO.UMA_CHAVE) < (root -> UMA_CHAVE))
       root->left = InsertTree_BIN(root->left, INFO); // MENOR: ESQUERDA
       else
       root->right = InsertTree_BIN(root->right, INFO);// MAIOR: DIREITA
   }

   //printf("\n Retorno da NOVA raiz : %x ", X );
   return root; // falhando em chave duplicada .... todo fluxo passa aqui
}
//======================================================//
// Feito as pressas ... meio longo ... deve ser melhorado
<<<<<<< HEAD
BIN_TREE * InsertTree_ITERATIVO (BIN_TREE *NOH_RAIZ, DATA_TREE INFO )
=======
BIN_TREE * InsertTree_ITERATIVO(BIN_TREE *NOH_RAIZ, DATA_TREE INFO )
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
{ // cria um no ao chegar numa folha na arvore ...
   if (NOH_RAIZ == NULL) // UMA UNICA VEZ
  {
   // cria um no ao chegar numa arvore VAZIA
<<<<<<< HEAD
   BIN_TREE * X = cria_no_BIN();
	  X ->  UMA_CHAVE = INFO . UMA_CHAVE;
=======
   BIN_TREE * X = cria_no_BIN(); 
	X ->  UMA_CHAVE = INFO . UMA_CHAVE; 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
    strcpy( X -> UM_NOME , INFO . UM_NOME);
    X -> left  = NULL;  // Aterramentos
	  X -> right = NULL;  // Aterramentos
    return X; // serah a raiz pois estava vazia a mesmo
    }
<<<<<<< HEAD

  BIN_TREE * predecessor = NOH_RAIZ;
  BIN_TREE * ancora = NOH_RAIZ; // PODERIA SER USADO um TEMP
  // mas a raiz existente eh a MESMA
  char link_lr; // uma chave Left ou Right
  while ( NOH_RAIZ!= NULL )
    {
      if ( INFO.UMA_CHAVE < (NOH_RAIZ -> UMA_CHAVE) )
=======
  	
  BIN_TREE * predecessor = NOH_RAIZ;
  BIN_TREE * ancora = NOH_RAIZ; // PODERIA SER USADO um TEMP
  // mas a raiz existente eh a MESMA
  char link_lr; // uma chave Left ou Right  
  while ( NOH_RAIZ!= NULL ) 
     {
      if ( INFO.UMA_CHAVE < (NOH_RAIZ -> UMA_CHAVE) ) 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
      {  predecessor = NOH_RAIZ;
		     link_lr = 'l';
      // alvo menor que o valor corrente da raiz
         NOH_RAIZ = NOH_RAIZ->left; // AVANCA
       }
       // alvo MAIOR que o valor corrente da raiz
      else if ( INFO.UMA_CHAVE > (NOH_RAIZ-> UMA_CHAVE) )
         {  predecessor = NOH_RAIZ;
			      link_lr = 'r';
            NOH_RAIZ = NOH_RAIZ->right;
<<<<<<< HEAD
         }
=======
          }
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
      else if ( INFO.UMA_CHAVE == (NOH_RAIZ-> UMA_CHAVE) )
         { printf("CHAVE DUPLICADA -- jah esta na arvore");
		       getchar();
		       return ancora;
		  }

     } // fim do while

<<<<<<< HEAD
   // ALOCA E COPIA etc
   BIN_TREE * X = cria_no_BIN();
   X ->  UMA_CHAVE = INFO . UMA_CHAVE;
=======
   // ALOCA E COPIA etc 
   BIN_TREE * X = cria_no_BIN(); 
	X ->  UMA_CHAVE = INFO . UMA_CHAVE; 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
   strcpy(X -> UM_NOME , INFO . UM_NOME);
   //printf("\n %d : %x : %s", X -> UMA_CHAVE , X , X -> UM_NOME );
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
int num_nos_ABB( BIN_TREE *root)
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
<<<<<<< HEAD
// A MAIOR PROFUNDIDADE = ALTURA DE UN NO  -- Faca a versao iterativa
=======
// A MAIOR PROFUNDIDADE = ALTURA DE UNO  -- Faca a versao iterativa
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
int altura_ABB( BIN_TREE *root )
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
<<<<<<< HEAD
=======

>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
int fator_balanco_ABB( BIN_TREE *root )
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
/* ***********************************************/
// recursive version for search in BINARY tree
BIN_TREE * search_basic ( BIN_TREE *tree, int key )
{
<<<<<<< HEAD
  if ( tree == NULL )
  {
    return NULL; // vazio ou NAO ENCONTRADO
  }
    else if ( key == tree -> UMA_CHAVE ) {
    return tree;
  }
    else if ( key < tree -> UMA_CHAVE ) {
    return search_basic ( tree -> left, key );
  }
    else {
=======
  if ( tree == NULL ) 
  {
    return NULL; // vazio ou NAO ENCONTRADO
  } 
    else if ( key == tree -> UMA_CHAVE ) {
    return tree;
  } 
    else if ( key < tree -> UMA_CHAVE ) {
    return search_basic ( tree -> left, key );
  } 
   else {
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
    return search_basic ( tree -> right, key );
  }
}
/* ***********************************************/


// ==================================================== //

 /* TreeSearch: search for target starting at node root.
Pre:   The tree to which root points has been created.
Post: The function returns a pointer to a tree node that matches target
or NULL if the target is not in the tree.
 */

BIN_TREE *TreeSearch (BIN_TREE *NOH_RAIZ, int ALVO)
{
   if ( ALVO == ( NOH_RAIZ-> UMA_CHAVE) ) // achou!!!
    {return NOH_RAIZ;
<<<<<<< HEAD
    }
    else if ( ALVO < (NOH_RAIZ -> UMA_CHAVE) )
    {
	   NOH_RAIZ = TreeSearch(NOH_RAIZ->left, ALVO);
	   return NOH_RAIZ;
    }
   // RAMO ESQUERDO
    //return(TreeSearch(NOH_RAIZ->left, ALVO));
    // alvo menor que o valor corrente da raiz
     else if ( ALVO > (NOH_RAIZ-> UMA_CHAVE) )
    //return (TreeSearch(NOH_RAIZ->right, ALVO));
      {
				NOH_RAIZ = TreeSearch(NOH_RAIZ->right, ALVO);
        return NOH_RAIZ;
      }
      else
      return NULL;
=======
    }	 
    else if ( ALVO < (NOH_RAIZ -> UMA_CHAVE) ) 
      {
	   NOH_RAIZ = TreeSearch(NOH_RAIZ->left, ALVO);
	   return NOH_RAIZ;
	  }       
    
   // RAMO ESQUERDO
   
    //return(TreeSearch(NOH_RAIZ->left, ALVO));
      // alvo menor que o valor corrente da raiz
     else if ( ALVO > (NOH_RAIZ-> UMA_CHAVE) )
    //return (TreeSearch(NOH_RAIZ->right, ALVO));
      { NOH_RAIZ = TreeSearch(NOH_RAIZ->right, ALVO);
        return NOH_RAIZ;       
      } 
      else
      return NULL;       
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
}

// ==================================================== //
// Function to check the given key exist or not  e return its node
BIN_TREE * iterative_search_basic (BIN_TREE  *root, int key)
{
  // Traverse untill root reaches to dead end
    while (root != NULL)
    {
        // pass right subtree as new tree
        if (key > root -> UMA_CHAVE)
            root = root-> right;    // alvo maior que o valor corrente da raiz
<<<<<<< HEAD

=======
 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
        // pass left subtree as new tree
        else if (key < root -> UMA_CHAVE)
            root = root->left;    // alvo menor que o valor corrente da raiz
        else
            return root;// if the key is found return 1
    }
    return NULL;
<<<<<<< HEAD
=======
}
// adaptada por CCS
// VERSAO NAO RECURSIVA --- 90%
BIN_TREE * TreeSearch_ITERATIVO (BIN_TREE *NOH_RAIZ, int ALVO)
{
  while( ALVO != (NOH_RAIZ-> UMA_CHAVE)  || ( NOH_RAIZ == NULL ) ) 
   // ( NOH_RAIZ != NULL )
  //  ALVO != (NOH_RAIZ-> UMA_CHAVE)  ) 
  // ||    ) // NAO achou!!! 
   {
     if ( ALVO < (NOH_RAIZ -> UMA_CHAVE) ) 
     // alvo menor que o valor corrente da raiz
       NOH_RAIZ = NOH_RAIZ -> left;
       // alvo MAIOR que o valor corrente da raiz
         else if ( ALVO > (NOH_RAIZ ->  UMA_CHAVE) )
         NOH_RAIZ = NOH_RAIZ -> right;
     
     } // fim do while

      if ( ALVO == (NOH_RAIZ ->  UMA_CHAVE) ) // achou!!!
      return NOH_RAIZ;  // achou OK
      else
      return NULL; // vazia ou nao estah
     
      printf("\n ARVORE VAZIA .... ????"); 
      printf("\n Ou noh ALVO NAO estava na arvore era: %d", ALVO); 
    
     //return NOH_RAIZ;
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
}
// adaptada por CCS
// VERSAO NAO RECURSIVA --- 90%
BIN_TREE * TreeSearch_ITERATIVO (BIN_TREE *NOH_RAIZ, int ALVO)
{
  while( ALVO != (NOH_RAIZ-> UMA_CHAVE)  || ( NOH_RAIZ == NULL ) )
   // ( NOH_RAIZ != NULL )
  //  ALVO != (NOH_RAIZ-> UMA_CHAVE)  )
  // ||    ) // NAO achou!!!
   {
     if ( ALVO < (NOH_RAIZ -> UMA_CHAVE) )
     // alvo menor que o valor corrente da raiz
       NOH_RAIZ = NOH_RAIZ -> left;
       // alvo MAIOR que o valor corrente da raiz
         else if ( ALVO > (NOH_RAIZ ->  UMA_CHAVE) )
         NOH_RAIZ = NOH_RAIZ -> right;

     } // fim do while

      if ( ALVO == (NOH_RAIZ ->  UMA_CHAVE) ) // achou!!!
      return NOH_RAIZ;  // achou OK
      else
      return NULL; // vazia ou nao estah

      printf("\n ARVORE VAZIA .... ????");
      printf("\n Ou noh ALVO NAO estava na arvore era: %d", ALVO);

     //return NOH_RAIZ;
}
// ==================================================== //

// ESTA  **
<<<<<<< HEAD
int deltree(BIN_TREE * tree)
=======
int deltree(BIN_TREE * tree) 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
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
// ESTA quase BOM ....
<<<<<<< HEAD
int deltree_TRUE(BIN_TREE ** tree)
=======
int deltree_TRUE(BIN_TREE ** tree) 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
{
  if ( (*tree) == NULL )
   { return 0; // true;
   }

   deltree_TRUE( &((*tree)->left) );
   deltree_TRUE( &((*tree)->right) );
   // EXCLUIR O NOH CORRENTE APOS EXCLUIR AS SUB-ARVORES

   free( *tree ); // libera folha ou espaco
   (*tree) = NULL; // efetivamente redireciona o ponteiro
   // talvez C++ ou compilador moderno ... torne isto em NULL
   return 1; // true;
 }
// ==================================================== //
<<<<<<< HEAD
//
=======
// 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
void print_NODE(BIN_TREE * node)
{
     /* print the data of node */
     //printf("\n End: %d ", node); //%x
<<<<<<< HEAD
     printf("\t CHAVE: %d :", node-> UMA_CHAVE);
=======
     printf("\t CHAVE: %d :", node-> UMA_CHAVE);  
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
     printf("\t NOME: %s ", node-> UM_NOME);
     return;
}
// ==================================================== //
void printInorder(BIN_TREE * node)
{
   if (node == NULL)
      return;

     /* VISITE A SUB ARVORE A ESQUERDA */
     printInorder(node->left);
     /* then print the data of node */
<<<<<<< HEAD
     printf("\n: %d :", node-> UMA_CHAVE);
     printf("\t NOME: %s ", node-> UM_NOME);
     //printf("\t END NOH: %x ",  node );
=======
     printf("\n: %d :", node-> UMA_CHAVE);  
     printf("\t NOME: %s ", node-> UM_NOME);
     //printf("\t END NOH: %x ",  node );  
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
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
void printPreorder(BIN_TREE * node)
{
  if (node == NULL)
      return;
     /* first print the data of node */
<<<<<<< HEAD
     printf("\n: %d :", node-> UMA_CHAVE);
     printf("\t NOME: %s ", node-> UM_NOME);
=======
     printf("\n: %d :", node-> UMA_CHAVE);  
     printf("\t NOME: %s ", node-> UM_NOME);  
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
     /*  then recur on left child */
     printPreorder(node->left);
     /* now recur on right child */
     printPreorder(node->right);
}

// ==================================================== //
void printPosorder(BIN_TREE * node)
{
  if (node == NULL)
      return;
     /* first recur on left child */
     printPosorder(node->left);
     /* then recur on right child */
     printPosorder(node->right);
     /* now print the data of node */
<<<<<<< HEAD
     printf("\n: %d :", node-> UMA_CHAVE);
     printf("\t NOME: %s ", node-> UM_NOME);
}
/* ***********************************************/
void pretty_print ( BIN_TREE *tree, int level )
{ //
=======
     printf("\n: %d :", node-> UMA_CHAVE);  
     printf("\t NOME: %s ", node-> UM_NOME);  
}
/* ***********************************************/
void pretty_print ( BIN_TREE *tree, int level )
{ // 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
  if ( tree == NULL ) {
    printf ( " " );
  } else {
    pretty_print ( tree->right, level + 1 );
    printf ( "%d: %s",  tree-> UMA_CHAVE, tree-> UM_NOME );
    pretty_print ( tree->left, level + 1 );
  }
}
<<<<<<< HEAD
/* ***********************************************/
=======
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
// Function to print binary tree in 2D
// It does reverse inorder traversal
void print2DUtil(BIN_TREE*root, int space)
{
    // Base case
    if (root == NULL)
        return;
<<<<<<< HEAD

    // Increase distance between levels
    space += COUNT;

    // Process right child first
    print2DUtil(root->right, space);

=======
 
    // Increase distance between levels
    space += COUNT;
 
    // Process right child first
    print2DUtil(root->right, space);
 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
    // Print current node after space
    // count
    printf("\n");
    for (int i = COUNT; i < space; i++)
        printf(" ");
    printf("%d\n", root-> UMA_CHAVE);
<<<<<<< HEAD

    // Process left child
    print2DUtil(root->left, space);
}
/* ***********************************************/
=======
 
    // Process left child
    print2DUtil(root->left, space);
}
 
>>>>>>> c043a6b25a50902341f0a974260b14f499b3fefe
