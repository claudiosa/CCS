// ==================================================== //
#include "arv_bin.h"
// EXCLUSAO ... "IMPLEMENTADA "
// FALTA ARRUMAR .................

// Remove um NO em uma arvore binaria
BinTreeNode * removeNO(BinTreeNode *raiz, int chave) {
	BinTreeNode *pai, *no, *p, *q;
	pai = NULL;
	no = buscaNo(raiz, chave, &pai);// procura o local do alvo
	if (no == NULL) {
		return (raiz);//se o NO não existir não existe remoção a ser feita
	}
	if (!no->left || !no->right) {// verifica se o NO não passui filhos
		if (!no->left) {//se o NO a esquesda não existir então pega o NO a direita
			q = no->right;
		} else {
			q = no->left;//se o NO a esquerda existir pega o proprio
		}
	} else {//se o NO tiver filhos
		p = no;//referencia do NO alvo
		//caminha ao NO mais a direita do NO a esquerda
		q = no->left;//referencia do NO da esquerda
		while (q->right) {//acha o NO mais a direita do NO a esquerda do alvo
			p = q;
			q = q->right;
		}
		if (p != no) {//verifica se o NO alvo não é o mesmo no do No a ser "promovido/substituto"
			p->right = q->left;//pai do NO ah ser promovido herda o filho do NO ah ser promovido
			q->left = no->left;//o filho a esquerda do NO ah ser promovido recebe o filho ah esquerda do NO a ser removido
		}
		q->right = no->right;//o filho a direita do NO ah ser removido recebe o fliho ah direita do NO a ser removido
	}
	if (!pai) {//verifica se o no a ser removido não é a raiz
		free(no);//MATA o NO
		return (q);//retorna a nova raiz
	}
	if (chave < pai-> dados.UMA_CHAVE) {//verifica em qual dos filhos estava o NO a ser removido
		pai->left = q;//faz com que o NO a ser promovido, seja promovido
		free(no);//MATA o NO
	} else {
		pai->right = q;//faz com que o NO a ser promovido, seja promovido
		free(no);//MATA o NO
	}
	return (raiz);//retorna a raiz da arvore
}


/*

/* Given a non-empty binary search tree, return the node with minimum
   key value found in that tree. Note that the entire tree does not
   need to be searched. 
   VEIO de http://www.geeksforgeeks.org/binary-search-tree-set-2-delete/
   * */
BinTreeNode * minValueNode(BinTreeNode * node)
{
   BinTreeNode * current = node;
 
    /* loop down to find the leftmost leaf */
    while (current->left != NULL)
        current = current -> left;
 
    return current;
}
// versao recursiva
// VEIO DE https://helloacm.com/how-to-delete-a-node-from-a-binary-search-tree/ 
BinTreeNode * Delete_NODE(BinTreeNode *root, int X_No) {
  if (root == NULL) {
     return NULL;
  }
  if (X_No < root-> dados.UMA_CHAVE) {  // data is in the left sub tree.
      root->left = Delete_NODE(root->left, X_No );
  } else if (X_No > root-> dados.UMA_CHAVE) { // data is in the right sub tree.
      root->right = Delete_NODE(root->right, X_No );
  } else {
     // case 1: no children
     if (root->left == NULL && root->right == NULL) {
        free(root); // wipe out the memory, in C, use free function
        root = NULL;
     }
     // case 2: one child (right)
     else if (root->left == NULL) {
        BinTreeNode * temp = root; // save current node as a backup
        root = root->right;
        free(temp);
     }
     // case 3: one child (left)
     else if (root->right == NULL) {
       BinTreeNode  * temp = root; // save current node as a backup
        root = root->left;
        free(temp);
     }
     // case 4: two children
     else {
		//O MENOR VALOR da sub-ARVORE A DIREITA ... o qual
		// vai estar a esquerda .... 
        BinTreeNode * temp = minValueNode(root->right); // find minimal value of right sub tree
        root-> dados.UMA_CHAVE = temp-> dados.UMA_CHAVE; // duplicate the node
        root->right = Delete_NODE(root->right, temp-> dados.UMA_CHAVE); // delete the duplicate node
     }
  }
  return root; // parent node can update reference
}
 
   
// ================================================================= //
//Procura um No expecifico Parametros:
// *raiz = No de inicio da busca
//  ch   = Numero da chave
// **pai = será retornado o valor do pai do no que foi buscado
BinTreeNode *buscaNo(BinTreeNode *raiz, int ch, BinTreeNode **pai) {
	BinTreeNode *atual = raiz;
	*pai = NULL;
	while (atual) {
		if (atual-> dados.UMA_CHAVE == ch) {//Achou
			return (atual);//retorna onde a cahve foi encontrada
		}
		*pai = atual;
		if (ch < atual-> dados.UMA_CHAVE) {//se a cahve for menor procura a esquerda
			atual = atual->left;
		} else {//se não procura a direita
			atual = atual->right;
		}
	}
	return (NULL);//se não achou retorna NULL
} 
// ================================================================= //
