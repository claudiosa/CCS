
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C
#include <stdio_ext.h>

/*
Codigos adaptados a partir dos 2 livros usados pelo 
professor

*/

#define N 20 

struct struct_Tree_DATA {
    int UMA_CHAVE; // para fins de busca
    char UM_NOME[N]; // Evitar ponteiro aqui
} ;
typedef struct struct_Tree_DATA DATA_TREE;


struct struct_treenode {
    int UMA_CHAVE; // para fins de busca
    char UM_NOME[N]; // Evitar ponteiro aqui

    struct struct_treenode *left;
    struct struct_treenode *right;
} ;

typedef struct struct_treenode BIN_TREE;

void limpeza_teclado(void);
BIN_TREE * cria_no_BIN(void);
BIN_TREE * InsertTree_BIN( BIN_TREE * ,  DATA_TREE );
BIN_TREE * InsertTree_ITERATIVO(BIN_TREE * , DATA_TREE);
void printInorder(BIN_TREE * );
void printPreorder(BIN_TREE * );
void printPosorder(BIN_TREE * );

int deltree(BIN_TREE * ) ;
int deltree_TRUE(BIN_TREE ** tree);

BIN_TREE *TreeSearch(BIN_TREE *NOH_RAIZ, int ALVO);
BIN_TREE *TreeSearch_ITERATIVO(BIN_TREE *NOH_RAIZ, int ALVO);

// POR FAZER MUDANDO O TIPO DE RETORNO
DATA_TREE *TreeSearch_ITERATIVO_02(BIN_TREE *NOH_RAIZ, int ALVO);


int num_nos_ABB( BIN_TREE *root);
void print_NODE(BIN_TREE * node);
int lendo_dados( BIN_TREE ** pt_tree  );


// do arquivo do exclui ....
BIN_TREE * remove_NOH_ABB(BIN_TREE *raiz, int chave) ;
BIN_TREE * minValueNode(BIN_TREE * node);
BIN_TREE * Delete_NODE(BIN_TREE *root, int data);
BIN_TREE * buscaNo(BIN_TREE *raiz, int ch, BIN_TREE **pai);

//BIN_TREE *remove_NOH_BIN (BIN_TREE *, int ALVO) ;
int altura_ABB( BIN_TREE *root);
int fator_balanco_ABB( BIN_TREE *root );
int maior (int x, int y);
