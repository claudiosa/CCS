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



/**************************************************************/
arv_bin * Del_No_3( arv_bin * raiz, char * X )
	{ /* Versao Recursiva ==> CCS */
		arv_bin *pai_X, *aux1, *aux2, *end_X;
		/* verifica se o noh em questao, eh o procurado a excluir */

	  pai_X = achar_pai (root , X); /* retorna o pai de X */
	  /* pega o end. de X */
	  end_X = TreeSearch( root , X );

	  if ( end_X == pai )
	  {
		 aux1 = end_X -> left ; /* serah o  filho mais
		 a esquerda da sub arvore da direita */
		 aux2 = end_X -> right ;
		 pai = end_X -> right ;

		 while( aux2 -> left )
				aux2= aux2 -> left ;
	 /* aux2 is the leftmost node of right subtree*/

		aux2 -> left = aux1 ;
	/* Reattach left subtree. */
		free( end_X );
		return ( pai );


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
/*  Achar o PAI */
 arv_bin * achar_pai(arv_bin *root, char * target)
	{
	 arv_bin * pai;
		pai = NULL;
		if ( ! root )
		 return (NULL); /* se o for folha o arv. vazia */

		else
		  { /*1a. instrucao */
			if (EQ(target,root->left->info) ||EQ(target,root->right->info))
			return(root);
			/*2a. instrucao */
			else if (GT(target, root->info))

			  {pai = achar_pai(root -> right,  target);}
			  else
			  {pai = achar_pai(root -> left,  target);}

			return(pai);
		 } /* fim do if */
	}
/************************************************************/