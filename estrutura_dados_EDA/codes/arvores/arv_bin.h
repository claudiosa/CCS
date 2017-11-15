
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C
/*
Codigos adaptados a partir dos 2 livros usados pelo 
professor

*/

#define N 20 

struct struct_Tree_DATA {
    int UMA_CHAVE; // para fins de busca
    char UM_NOME[N]; // Evitar ponteiro aqui
} ;
typedef struct struct_Tree_DATA TreeEntry;


struct struct_treenode {
    TreeEntry dados;  // Veja a struct ACIMA
    struct struct_treenode *left;
    struct struct_treenode *right;
} ;

typedef struct struct_treenode BinTreeNode;

BinTreeNode * cria_no_BIN(void);
BinTreeNode * InsertTree_BIN( BinTreeNode * ,  TreeEntry );
void printInorder(BinTreeNode * );
void printPreorder(BinTreeNode * );
void printPosorder(BinTreeNode * );
int deltree(BinTreeNode * ) ;
int deltree_TRUE(BinTreeNode ** tree);
BinTreeNode *TreeSearch(BinTreeNode *NOH_RAIZ, int ALVO);
BinTreeNode *TreeSearch_ITERATIVO(BinTreeNode *NOH_RAIZ, int ALVO);
int sizeof_Tree_BIN( BinTreeNode *root);
void print_NODE(BinTreeNode * node);


BinTreeNode *remove_NOH_BIN (BinTreeNode *, int ALVO) ;
int altura_Tree_BIN( BinTreeNode *root);
int maior (int x, int y);
