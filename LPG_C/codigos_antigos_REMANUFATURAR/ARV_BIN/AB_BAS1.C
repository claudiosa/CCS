#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*int strcmp(const char *s1, const char *s2); */
#define LT(a,b) (strcmp( (a) , (b) ) < 0)
#define GT(a,b) (strcmp( (a) , (b) ) > 0)
#define EQ(a,b) (strcmp( (a) , (b) ) == 0)

   typedef struct treenode  arv_bin;
   typedef struct treenode {
      char    info[20];
      int     ordem;
      arv_bin  *left;
      arv_bin *right;
   }
   arv_bin;

   typedef  int Boolean;


   arv_bin * aloca_no(void)
   {
      arv_bin *  X;
      X =  (arv_bin *) malloc (sizeof (arv_bin));
      if ( ! X )
      {
         printf("\n problema de alocacao... de memoria");
         getchar();
      }
      else
      {
         X -> left = NULL;
         X -> right = NULL;
      }
      return (X);
   }

/* CreateTree:  create a tree.
  Pre:   None.
  Post: An empty binary search tree has been
        created to which root points. */
   void CreateTree(arv_bin **root)
   {
      *root = NULL;
   }
/* TreeEmpty:  TRUE if the tree is emtpy.
 Pre:   The tree to which root points has been created.
 Post: The function returns the value TRUE or FALSE according as  thetree is empty or not. */
   Boolean TreeEmtpy(arv_bin *root)
   {
      return root == NULL;
   }
/* Visita em Preorder */
   void Preorder(arv_bin * root )
   {
      if (root)
      {
         printf("\n Pre-Ordem::%s\t||\t %d" ,root->info, root->ordem);
         printf("\n Filhos  Esq: %s\t|| Dir: %s " ,root->left->info, root->right->info);
         Preorder( root->left );
         Preorder( root->right );
      }
   }
/* Visita em Inorder */
   void Inorder(arv_bin * root )
   {
      if (root)
      {
         Inorder(root->left );
         printf("\n In-Ordem:: %s\t||\t %d" ,root->info, root->ordem);
         Inorder(root->right );
      }
   }
/* Visita em Postorder */
   void Postorder(arv_bin * root )
   {
      if (root)
      {   Postorder(root->left);
         Postorder(root->right);
         printf("\n Pos-Ordem:: %s\t||\t %d" ,root->info, root->ordem);
      }
   }
/**************************************************************/
/*  InsertTree: insere um novo noh na arvore.newnode e x ==> sao
      os dados dessa ABBcontudo, a inclusao mantem as propriedadesda ABB,
       tal que a chave principal eh newnode*/
   arv_bin *InsertTree(arv_bin *root, char * newnode, int x)
   {
      if (!root)
      { /*    char *strcpy(char *dest, const char *src);
       */
         root = aloca_no();
         strcpy(root -> info , newnode);
         root -> ordem = x;
         root->left = root->right = NULL;
      }
      else if (LT( newnode , root -> info ))
         root->left = InsertTree(root->left, newnode, x);
      
      else
         root->right = InsertTree(root->right, newnode, x);
   
      return (root);
   }
/***************************************************/
 /* DeleteNodeTree: exclui um noh da arvore, mas,
 o ponteiro p tem o endereco real do noh a ser excluido:
(``The parameter p is the address of an actual link
(not a copy)  in a binary search tree, and p is not NULL.")
*/
   void DeleteNodeTree( arv_bin **p )
   {
      arv_bin *r = *p,  *q;
   /* used to find place for left subtree  */
      if ( r == NULL)
      {
         printf("\n Tentativa de exclusao de um no nao-existente !");
         printf("\n ou arvore vazia !");
         getchar();
      }
      else if (r->right == NULL)
      { *p = r->left;           /* Reattach left subtree.   */
         free(r);                /* Release node space.      */
      }
      else if (r->left == NULL)
      {  *p = r->right;          /* Reattach right subtree.  */
         free(r);
      }
      else {   /* Neither subtree is empty.   */
         for ( q = r->right;
             q->left;
             q = q->left )
            ;           /* leftmost node of right subtree*/
      
         q -> left = r -> left ;      /* Reattach left subtree. */
         *p = r->right ;              /* Reattach right subtree. */
         free(r);
         printf("\n %s||%d||%x||%x", r -> info, r->right,r->left );
         getchar();
      }
   }
/**************************************************************/
   arv_bin * Del_No_2( arv_bin * raiz, char * X )
   { /* Versao Recursiva */
   
      arv_bin *pai, *aux;
      /* verifica se o noh em questao, eh o procurado a excluir */
      if ( EQ (raiz -> info , X ) )
      { 
         /* nao hah dois nohs iguais... logo ... filhos = NULL */
         if ( (raiz -> left) == (raiz -> right))
         {
            printf("\n Arvore vazia abaixo da raiz !");
            free (raiz);
            return(NULL);
         }
         else if (raiz -> right == NULL)
         /* sub arvore dir nula */
         { pai = raiz -> left;           /* Reattach left subtree.   */
            free(raiz);                /* Release node space.      */
            return(pai);
         }
         else if (raiz -> left == NULL)
         /* sub arvore esquerda nula */
         {  pai = raiz -> right;          /* Reattach right subtree.  */
            free(raiz);
            return (pai);
         }
         else {   /* Neither subtree is empty.   */
         /* as duas encontram-se presentes */
            aux = raiz -> right;
            pai = raiz -> right;
         
            while( pai -> left )
               pai = pai -> left ;
          /* leftmost node of right subtree*/
         
            pai -> left = raiz -> left;      /* Reattach left subtree. */
          /* Reattach right subtree. */
            free(raiz);
            return (aux);
         }
      } /* em caso do noh nao ser o procurado.... */
      if ( GT ( X,  raiz -> info ) )
      { 
         if (raiz -> right != NULL)
            raiz -> right = Del_No_2(raiz -> right, X);
         else
         {
            printf("\n Esse noh nao existe !");
            return(raiz);
         }
      }
      else
      {   
         if (raiz -> right != NULL)
            raiz -> left = Del_No_2(raiz -> left, X);
         else
         {
            printf("\n Esse noh nao existe !");
            return(raiz);
         }
      }
      return (raiz);
   }
/************************************************/
/* TreeSearch: search for target starting at node root.
Pre:   The tree to which root points has been created.
Post: The function returns a pointer to a tree node that matches targetor
NULL if the target is not in the tree. */
   arv_bin * TreeSearch(arv_bin *root, char * target)
   {
      if (root)
         if (LT(target, root->info))
            root = TreeSearch(root->left, target);
         
         else if (GT(target, root->info))
            root = TreeSearch(root->right, target);
   
      return root;
   }
/************************************************************/