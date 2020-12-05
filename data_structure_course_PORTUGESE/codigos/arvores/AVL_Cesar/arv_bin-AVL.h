
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C


struct struct_Tree_DATA {
	int intero;
	char caracter;
	float flutuante;
} ;
typedef struct struct_Tree_DATA TreeEntry;

struct struct_treenode {
	TreeEntry dados;
	struct struct_treenode *left;
	struct struct_treenode *right;
	int chave;
	int altura;
} ;

typedef struct struct_treenode BinTreeNode;

BinTreeNode * cria_no_BIN();
BinTreeNode * InsertTree_BIN(BinTreeNode *root, int chave );
BinTreeNode * InsertTree_ITERATIVO(BinTreeNode * , int chave);
void printInorder(BinTreeNode * );
void printPreorder(BinTreeNode * );
void printPosorder(BinTreeNode * );
BinTreeNode *TreeSearch(BinTreeNode *NOH_RAIZ, int ALVO);
BinTreeNode *TreeSearch_ITERATIVO(BinTreeNode *NOH_RAIZ, int ALVO);
int sizeof_Tree_BIN( BinTreeNode *root);

BinTreeNode *remove_NOH_BIN (BinTreeNode *, int ALVO) ;
int altura_Tree_BIN( BinTreeNode *root);
int maior (int x, int y);

int altura_ABB( BinTreeNode *root);
int fator_balanco_ABB( BinTreeNode *root );


int deltree(BinTreeNode * ) ;
int deltree_TRUE(BinTreeNode ** tree);
void print_NODE(BinTreeNode * node);

int numeroNos(BinTreeNode *raiz);
void exibirArvore(BinTreeNode *raiz);
BinTreeNode *buscaNo(BinTreeNode *raiz, int ch, BinTreeNode **pai);
BinTreeNode *removeNO(BinTreeNode *raiz, int chave);
BinTreeNode *criaNoAVL(int chave, TreeEntry dado);
BinTreeNode *inicializa();

BinTreeNode *direita(BinTreeNode *r);
BinTreeNode *esquerda(BinTreeNode *r);
BinTreeNode *esquerdaDireita(BinTreeNode *r);
BinTreeNode *direitaEsquerda(BinTreeNode *r);
int altura(BinTreeNode *raiz);
BinTreeNode *insereAVL(BinTreeNode *raiz, int chave, TreeEntry dado);
BinTreeNode *removeNO_AVL(BinTreeNode *raiz, int chave);