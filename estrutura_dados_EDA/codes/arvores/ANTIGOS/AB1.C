#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

   typedef struct treenode  arv_bin;
   typedef struct treenode {
      char    info[20];
      int     ordem;
      arv_bin  *left;
      arv_bin *right;
   } arv_bin;

   void CreateTree(arv_bin **root);
   arv_bin * InsertTree(arv_bin * X, char * Y, int Z);
   void DeleteNodeTree( arv_bin **p );
   arv_bin * TreeSearch(arv_bin *root, char * target)  ;
   void Inorder(arv_bin * X );
   void Preorder(arv_bin * X ) ;
	void Postorder(arv_bin * root );
	arv_bin * Del_No_2( arv_bin * raiz, char * X );

   void main(void)
   {
      int seq;
      char *vetor[]= {
      "joinville","paris","veneza","bruxelas",
      "vancouver","londres","moscou","luxemburgo",
      "glascow", "oxford","york", "austin",
      "montreal" };
   
      char nome[20];
     /* criar uma arvore .... */
      arv_bin    Arv_fisica;
      arv_bin * TREE,  * end_nome;

      TREE = & Arv_fisica;
      CreateTree(  & TREE ); /* inicializa */
   
      for ( seq = 0 ; seq < 13 ; seq++ )
		TREE = InsertTree(TREE, vetor[seq], seq);
		Preorder( TREE );

		do
		{
		  printf("\n Quem serah excluido (z: para terminar): ?");
		  gets(nome);
		  printf("\t\t Leu  ===> %s \n", nome );
		  TREE = Del_No_2( TREE, nome );
	//      end_nome = TreeSearch( TREE , nome );
  //       DeleteNodeTree( & end_nome );
		 Preorder( TREE );

		} while(strcmp("z", nome ) != 0);

		Inorder( TREE );
		Postorder( TREE );
	}