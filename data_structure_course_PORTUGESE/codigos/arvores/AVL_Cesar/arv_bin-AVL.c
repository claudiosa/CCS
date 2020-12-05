#include "arv_bin-AVL-Refazendo.h"

/*Podem haver duplicatas de funções uma vez que possui as funções criadas anteriormente pelo professor para ser utilizado
  em uma arvore BINARIA de BUSCA(comentarios feitos pelo professor), as funções para Arvore AVL estão logo abaixo*/

void CreateTree(BinTreeNode **root) {
	*root = NULL;
}

// ALOCA UM NO DA ARVORE
BinTreeNode * cria_no_BIN() {
	BinTreeNode *X;
	X =  (BinTreeNode *) malloc (sizeof (BinTreeNode));
	if ( ! X ) {
		printf("\n problema de alocacao... de memoria");
		getchar();
	}
	else {
		X -> left = NULL;
		X -> right = NULL;
	}
	return X;
}

/* TreeEmpty:  TRUE if the tree is emtpy.

Pre:   The tree to which root points has been created.
Post: The function returns the value TRUE or FALSE according as the
tree is empty or not.
 */
bool TreeEmtpy(BinTreeNode *root) {
	if (root == NULL)
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
BinTreeNode * InsertTree_BIN(BinTreeNode *root, int chave ) {
	if (root == NULL) {
		// cria um no ao chegar numa folha na arvore ...
		BinTreeNode * X = cria_no_BIN();
		X->chave = chave;
		//strcpy(X -> dados.UM_NOME , INFO . UM_NOME);
		// Tipo TreeEntry
		//printf("\n %d : %x : %s", X -> dados.UMA_CHAVE , X , X -> dados.UM_NOME );
		X -> left = X -> right = NULL;
		return X; // CUIDADO ... NAO ESQUECER	---------------------------------	modificado, mas dá pra melhorar a recurção
		// TINHA ESQUECIDO DE ATUALIZAR ... 2 horas estudo
		// pois eh o ultimo inserido e a ULTIMA CHAMADA RECURSIVA ....
	} else {
		if ((chave) == (root -> chave)) {
			printf("\n CHAVE DUPLICADA !!!");
			printf("\n VIOLA DEFINICAO DE ABB !!!\n");
			printf("\n TINHA: %d | ENTRY: %d\n", root -> chave, chave );
			getchar();
		}
		// SEGUE A BUSCA ATE UMA FOLHA
		else if ((chave) < (root -> chave))
			root->left = InsertTree_BIN(root->left, chave); // MENOR: ESQUERDA
		else
			root->right = InsertTree_BIN(root->right, chave);// MAIOR: DIREITA
	}

	return root; // falhando em chave duplicada .... todo fluxo passa aqui
}


int sizeof_Tree_BIN( BinTreeNode *root) {
	if (root == NULL)
		return 0;
	else
		return ( sizeof_Tree_BIN(root ->left) + 1 + sizeof_Tree_BIN(root ->right));
}

//======================================================//
// NUMERO DE NOS -- Faca a versao iterativa
int altura_Tree_BIN( BinTreeNode *root) {
	/*int qt_left, qt_right;*/
	if (root == NULL) {
		return 0;
	}

	/*qt_left = sizeof_Tree_BIN(root ->left); // sub-arv esquerda
	qt_right = sizeof_Tree_BIN(root ->right); // sub-arv direita
	return ( qt_left + 1 + qt_right );*/

	return (sizeof_Tree_BIN(root ->left) + 1 + sizeof_Tree_BIN(root ->right));
}

//======================================================//

int altura_ABB( BinTreeNode *root ) {
	int A1, A2;
	if (root == NULL)
		return -1;

	A1 = altura_ABB(root ->left);
	A2 = altura_ABB(root ->right);
	if (A1 > A2)
		return (A1 + 1);
	else
		return (A2 + 1);
	//return ( maior (A1 , A2) + 1 );
}

int maior (int x, int y) {
	if (x > y)
		return x;
	else
		return y;
}

/* TreeSearch: search for target starting at node root.
Pre:   The tree to which root points has been created.
Post: The function returns a pointer to a tree node that matches target
or NULL if the target is not in the tree.
*/

BinTreeNode *TreeSearch(BinTreeNode *NOH_RAIZ, int ALVO) {
	if ( NOH_RAIZ != NULL ) {
		// RAMO ESQUERDO
		if ( ALVO == (NOH_RAIZ-> chave) ) // achou!!!
			return NOH_RAIZ;
		if ( ALVO > (NOH_RAIZ-> chave) )
			return (TreeSearch(NOH_RAIZ->right, ALVO));

		if ( ALVO < (NOH_RAIZ -> chave) )
			// alvo menor que o valor corrente da raiz
			return (TreeSearch(NOH_RAIZ->left, ALVO));

		else {
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

// VERSAO NAO RECURSIVA
BinTreeNode *TreeSearch_ITERATIVO(BinTreeNode *NOH_RAIZ, int ALVO) {
	while ( ALVO != (NOH_RAIZ-> chave) ) { // NAO achou!!!
		if ( ALVO < (NOH_RAIZ -> chave) )
			// alvo menor que o valor corrente da raiz
			NOH_RAIZ = NOH_RAIZ->left;

		else if ( ALVO > (NOH_RAIZ-> chave) )
			NOH_RAIZ = NOH_RAIZ->right;
	} // fim do while

	if ( ALVO == (NOH_RAIZ-> chave) ) // achou!!!
		return NOH_RAIZ;

	else if ( NOH_RAIZ == NULL ) {
		printf("\n ARVORE VAZIA ....");
		getchar();
		// system("exit"); // ver isto depois
	}
	else {
		printf("\n ALGUM Problema em TreeSearch : ALVO era: %d", ALVO);
		getchar();
		// system("exit"); // ver isto depois
	}
	return NOH_RAIZ;
}

// ==================================================== //

// ESTA quase BOM .... usando o outro por **
int deltree(BinTreeNode * tree) {
	if (tree == NULL)
		return 0; // true;

	deltree(tree->left);
	deltree(tree->right);
	// EXCLUIR O NOH CORRENTE APOS EXCLUIR AS SUB-ARVORES

	free(tree); // libera o ESPACO ... apenas isto
	tree = NULL; //  e aqui faz efetivamente ir para o VAZIO
	if (tree == NULL)
		printf("\n noh liberado");
	else {
		printf("\n noh NAO liberado");
		print_NODE(tree);
	}
	return 1; // true;

}


//*************************************
// ESTA quase BOM ....
int deltree_TRUE(BinTreeNode ** tree) {
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

BinTreeNode *remove_NOH_BIN (BinTreeNode *tree, int ALVO) {
	// pts auxiliares
	BinTreeNode
	*p,  /* p aponta para o NOH a ser removido */
	*q,  /* q aponta para o pai do NOH  ou p*/
	*rp, /* rp aponta que ira substituir o no p */
	*f,
	*s;  /* sucessor do no p */

	p = tree; // p tem tree
	q = NULL;

	/* procura o no com a chave INFO,
	p aponta para o no procurado
	e q aponta para o pai do no
	 pai_pai(q) --> pai(p) --> X
	*/
	while ( p != NULL && p->chave != ALVO) {
		q = p;
		if ( ALVO < p->chave)
			p = p->left;
		else
			p = p->right;
	} /* fim do while */
	if (!p) return NULL; /* a chave nao existe na arvore */
	// isto eh p == NULL
	/* agora iremos ver os dois primeiros casos,
	o no tem um filho  no maximo */
	if (p->left == NULL) // sem filho a leftuerda
		rp = p->right;
	else if (p->right == NULL) // idem direita
		rp = p->left;

// REFAZER ISTO
	else {   // vamos ao pior caso
		f = p;
		rp = p-> right;
		s = rp-> left;
		/* s eh sempre o filho left de rp */
		while (s != NULL) {
			f = rp;
			rp = s;
			s = rp->left;
		}
		/* neste ponto, rp e o sucessor em ordem de p */
		if (f != p) {
			/*  p nao e o pai de rp e rp == f->left */
			f->left = rp->right;
			/* remove o no rp de sua atual posicao e o
			substitui pelo filho direito de rp
			rp ocupa o lugar de p
			*/
			rp->right = p->right;
		}
		/* define o filho leftuerdo de rp de modo que rp
		ocupe o lugar de p
		*/
		rp->left = p->left;
	}
	/* insere rp na posicao ocupada anteriormente por p */
	if (q == NULL)
		tree = rp;
	else if (p == q->left)
		q -> left = rp;
	else
		q->right = rp;
	free(p);
	return rp;
}

// =================================== //

void printInorder(BinTreeNode * node) {
	//printf("+ ");
	if (node == NULL)
		return;

	/* VISITE A SUB ARVORE A ESQUERDA */
	printInorder(node->left);
	/* then print the data of node */
	printf("\nCHAVE: %d :", node->chave);
	printf("\tINTEIRO: %i ", node->dados.intero);
	printf("\tCARACTER: %c ", node->dados.caracter);
	printf("\tFLUTUANTE: %.2f ", node->dados.flutuante);
	//printf("\t END NOH: %x ",  node );
	/* now VISITE A SUB ARVORE A DIREITA */
	printInorder(node->right);
}

/* Preorder: visit each node of the tree in preorder.
Pre:  The binary tree to which root points has been created.
Post: The function Visit has been performed on every entry in the binary
tree in preorder sequence.
*/
// IMPRIMA SUB a esquerda e SUB a direita
void printPreorder(BinTreeNode * node) {
	//printf("+ ");
	if (node == NULL)
		return;
	/* first print the data of node */
	printf("\nCHAVE: %d :", node->chave);
	printf("\tINTEIRO: %i ", node->dados.intero);
	printf("\tCARACTER: %c ", node->dados.caracter);
	printf("\tFLUTUANTE: %.2f ", node->dados.flutuante);
	/*  then recur on left child */
	printPreorder(node->left);
	/* now recur on right child */
	printPreorder(node->right);
}

void printPosorder(BinTreeNode * node) {
	//printf("+ ");
	if (node == NULL)
		return;
	/* first recur on left child */
	printPosorder(node->left);
	/* then recur on right child */
	printPosorder(node->right);
	/* now print the data of node */
	printf("\nCHAVE: %d :", node->chave);
	printf("\tINTEIRO: %i ", node->dados.intero);
	printf("\tCARACTER: %c ", node->dados.caracter);
	printf("\tFLUTUANTE: %.2f ", node->dados.flutuante);
}
/************************************************/

// ==================================================== //

void print_NODE(BinTreeNode * node) {
	/* print the data of node */
	printf("\n End: %p ", node);
	printf("\tINTEIRO: %i ", node->dados.intero);
	printf("\tCARACTER: %c ", node->dados.caracter);
	printf("\tFLUTUANTE: %.2f ", node->dados.flutuante);
	return;
}
// ==================================================== //

int fator_balanco_ABB( BinTreeNode *root ) {
	int A1, A2;
	if (root == NULL)
		return -1;

	A1 = altura_ABB(root ->left);
	A2 = altura_ABB(root ->right);
	return (A1 - A2);
	// SE = 0 ... igual aos 2 lados
	// SE > 0 ... lado esquerdo eh MAIOR
	// SE < 0 ... lado direito eh MAIOR
}

/*======================================================================================================*/
/*		  							FIM DOS CODIGOS FEITOS PROFESSOR			 						*/
/*======================================================================================================*/


// ==================================================== //
// Retorna o numero de nos da Arvore
int numeroNos(BinTreeNode *raiz) {
	if (!raiz) {//verifica se a raiz existe (verifica se existe algo para onde o ponteiro aponta), no caso se não existe
		return 0;// Se a raiz for NULL retorna 0
	}
	return (numeroNos(raiz->left) + 1 + (numeroNos(raiz->right)));// Retorna a soma dos nos das subArvores mais a soma da propria
}

// ==================================================== //
//Exibe uma previa de como a arvore está  (não ajuda para grande quantidade dados)
void exibirArvore(BinTreeNode *raiz) {
	if (raiz != NULL) {
		printf("%i", raiz->chave );
		printf("( ");
		exibirArvore(raiz->left);//Imprime todos os nos ah esquerda
		exibirArvore(raiz->right);//Imprime todos os nos ah direita
		printf(" ) ");
	}
}

// ==================================================== //
//Procura um No expecifico Parametros:
// *raiz = No de inicio da busca
//  ch   = Numero da chave
// **pai = será retornado o valor do pai do no que foi buscado
BinTreeNode *buscaNo(BinTreeNode *raiz, int ch, BinTreeNode **pai) {
	BinTreeNode *atual = raiz;
	*pai = NULL;
	while (atual) {
		if (atual->chave == ch) {//Achou
			return (atual);//retorna onde a cahve foi encontrada
		}
		*pai = atual;
		if (ch < atual->chave) {//se a cahve for menor procura a esquerda
			atual = atual->left;
		} else {//se não procura a direita
			atual = atual->right;
		}
	}
	return (NULL);//se não achou retorna NULL
}

// ==================================================== //
// Remove um NO em uma arvore binaria
BinTreeNode *removeNO(BinTreeNode *raiz, int chave) {
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
	if (chave < pai->chave) {//verifica em qual dos filhos estava o NO a ser removido
		pai->left = q;//faz com que o NO a ser promovido, seja promovido
		free(no);//MATA o NO
	} else {
		pai->right = q;//faz com que o NO a ser promovido, seja promovido
		free(no);//MATA o NO
	}
	return (raiz);//retorna a raiz da arvore
}

// ==================================================== //
// Cria um NO
BinTreeNode *criaNoAVL(int chave, TreeEntry dado) {
	BinTreeNode *novoNo = (BinTreeNode *)malloc(sizeof(BinTreeNode));
	novoNo->dados = dado;
	novoNo->left = NULL;
	novoNo->right = NULL;
	novoNo->chave = chave;
	novoNo->altura = 0;
	return (novoNo);
}

// ==================================================== //
// inicializa a Arvore com NULL
BinTreeNode *inicializa() {
	return (NULL);
}

// ==================================================== //
// faz rotação para direita
BinTreeNode *direita(BinTreeNode *r) {
	BinTreeNode *aux = r->left;
	r->left = aux->right;
	aux->right = r;

	r->altura = maior(altura(r->right), altura(r->left)) + 1;//re-calcula a altura do NO na nova configuração
	aux->altura = maior(altura(aux->right), r->altura) + 1;//re-calcula a altura do NO na nova configuração
	return (aux);//retorna a nova Arvore
}

// ==================================================== //
//faz rotação para esquerda
BinTreeNode *esquerda(BinTreeNode *r) {
	BinTreeNode *aux = r->right;
	r->right = aux->left;
	aux->left = r;

	r->altura = maior(altura(r->right), altura(r->left)) + 1;//re-calcula a altura do NO na nova configuração
	aux->altura = maior(altura(aux->right), r->altura) + 1;//re-calcula a altura do NO na nova configuração
	return (aux);//retorna a nova Arvore
}

// ==================================================== //
// faz rotação esquerda direita
BinTreeNode *esquerdaDireita(BinTreeNode *r) {
	r->left = esquerda(r->left);//faz a rotação esquerda no NO da esquerda
	return (direita(r));//faz a rotação direita na raiz
}

// ==================================================== //
// faz rotação direita esquerda
BinTreeNode *direitaEsquerda(BinTreeNode *r) {
	r->right = direita(r->right);//faz a rotação direita no NO da direita
	return (esquerda(r));//faz a rotação esquerda no NO da esquerda
}

// ==================================================== //
// retorna a altura do NO corente
int altura(BinTreeNode *raiz) {
	if (!raiz) {
		return (-1);//se a raiz for NULL (folha), retorna -1. Pola definição folha tem altura -1
	}
	return (raiz->altura);//retorna a altura do NO vigente
}

// ==================================================== //
// insere um NO em uma Arvore AVL
BinTreeNode *insereAVL(BinTreeNode *raiz, int chave, TreeEntry dado) {
	if (!raiz) {// se a raiz for NULL cria o primeiro NO
		return (criaNoAVL(chave, dado));
	}
	if (chave == raiz->chave) {//se a chave já existe não é inserido nada
		return raiz;
	} else {
		if (chave < raiz->chave) {//verifica se o NO deve ser inserido na esquerda
			raiz->left = insereAVL(raiz->left, chave, dado);//chama recursivamente a função retornando o NO da nova arvore
			if ((altura(raiz->left) - altura(raiz->right)) == 2) {//verifica se o fator de balanceamento é igual a dois, antão a Arvore está desbalanceada
				if (chave < raiz->left->chave) {//verifica qual é o lado desbalanceado e realiza as rotações necessarias
					raiz = direita(raiz);
				} else {
					raiz = esquerdaDireita(raiz);
				}
			}
		} else {
			if (chave > raiz->chave) {//verifica se o NO deve ser inserido na direita
				raiz->right = insereAVL(raiz->right, chave, dado);
				if ((altura(raiz->right) - altura(raiz->left)) == 2) {//verifica se o fator de balanceamento é igual a dois, antão a Arvore está desbalanceada
					if (chave > raiz->right->chave) {//verifica qual é o lado desbalanceado e realiza as rotações necessarias
						raiz = esquerda(raiz);
					} else {
						raiz = direitaEsquerda(raiz);
					}
				}
			}
		}
	}
	raiz->altura = maior(altura(raiz->left), altura(raiz->right)) + 1;//Calcula a altura do novo NO
	return (raiz);//retorna a nova arvora
}

// ==================================================== //
//Procura um No expecifico Parametros:
// *raiz = No de inicio da busca
//  ch   = Numero da chave
// **pai = será retornado o valor do pai do no que foi buscado
// igual a função de busca anterior
BinTreeNode *buscaNo_AVL(BinTreeNode *raiz, int ch, BinTreeNode **pai) {
	BinTreeNode *atual = raiz;
	*pai = NULL;
	while (atual) {
		if (atual->chave == ch) {
			return (atual);
		}
		*pai = atual;
		if (ch < atual->chave) {
			atual = atual->left;
		} else {
			atual = atual->right;
		}
	}
	return (NULL);
}

// ==================================================== //
// Remove um No expecifico, Não garante um balanceamento perfeito
// se todos os NOs forem removido do mesmo lado da sub-Arvore a Arvore principal ficará desbalanceada
// Muito Parecido com o removeNO, com algumas auterações
BinTreeNode *removeNO_AVL(BinTreeNode *raiz, int chave) {// Incompleto
	BinTreeNode *pai, *no, *p, *q;
	pai = NULL;
	no = buscaNo_AVL(raiz, chave, &pai);
	if (no == NULL) {
		return (raiz);
	}
	if (!no->left || !no->right) {
		if (!no->left) {
			q = no->right;
		} else {
			q = no->left;
		}
	} else {
		p = no;
		q = no->left;
		while (q->right) {
			p = q;
			q = q->right;
		}
		if (p != no) {
			p->right = q->left;
			q->left = no->left;
		}
		q->right = no->right;
	}
	if (!(pai)) {
		free(no);
		return (q);
	}
	if (chave < pai->chave) {
		pai->left = q;
		free(no);
		if ((altura(pai->left) - altura(pai->right)) == 2) {
			if (chave < pai->left->chave) {
				pai = direita(pai);
			} else {
				pai = esquerdaDireita(pai);
			}
		}
		pai->altura = maior(altura(pai->left), altura(pai->right)) + 1;
	} else {
		pai->right = q;
		free(no);
		if ((altura(pai->right) - altura(pai->left)) == 2) {
			if (chave > pai->right->chave) {
				pai = esquerda(pai);
			} else {
				pai = direitaEsquerda(pai);
			}
		}
		pai->altura = maior(altura(pai->left), altura(pai->right)) + 1;/*
		return (raiz);*/
	}

	return (raiz);
}
