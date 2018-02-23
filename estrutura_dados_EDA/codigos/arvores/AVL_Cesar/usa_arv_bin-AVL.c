#include "arv_bin-AVL-Refazendo.h"

int main() {
	int chave = 0;
	BinTreeNode *pt_TREE;
	pt_TREE = inicializa();

	TreeEntry entrada;
	
	// Leitura dos dados pelos arquivos passados pelo professor
	while (scanf("%i  %c  %f", &(entrada.intero), &(entrada.caracter), &(entrada.flutuante)) != EOF) {
		chave = entrada.intero;
		pt_TREE = insereAVL(pt_TREE, chave, entrada);
		printf("\nINSERINDO i: %i c: %c f: %.2f (End: %p)", chave, entrada.caracter, entrada.flutuante, pt_TREE );
		printf("\nAgora a altura corrente  eh: %d :", altura( pt_TREE) );
		printf("\n");
	}

	// Imprime a Altura da arvore
	printf("Altura da Arvore: %i\n", altura(pt_TREE));
	
	// Imprime o numero de nos da arvore
	printf("\nNUMERO DE NOSH: %d", sizeof_Tree_BIN( pt_TREE) );

	// Imprime em Pre_Ordem, In_Ordem e Pos_ordem

	/*printf("\n");
	printf("\nSAIDA PRE: \n");
	printPreorder( pt_TREE );
	printf("\n");
	printf("\nSAIDA IN: \n");
	printInorder( pt_TREE );
	printf("\n");
	printf("\nSAIDA POS: \n");
	printPosorder( pt_TREE );*/
	for (int i = 200; i < 1000; ++i){
		pt_TREE=removeNO_AVL(pt_TREE, i);	//Possui um erro quando chega no 219.
		printf("\nRemovido No com chave %i.",i);

	}
	// Teste de remoção de nos expecificos.
	/*printf("\nRemovendo NOs com chave: 3, 80, 69 e 90.");
	pt_TREE=removeNO_AVL(pt_TREE, 3);
	printf("\nRemovido No com chave 3.");
	pt_TREE=removeNO_AVL(pt_TREE, 80);
	printf("\nRemovido No com chave 80.");
	pt_TREE=removeNO_AVL(pt_TREE, 69);
	printf("\nRemovido No com chave 69.");
	pt_TREE=removeNO_AVL(pt_TREE, 90);
	printf("\nRemovido No com chave 90.");*/

	printf("\n");
	printf("Altura da Arvore: %i\n", altura(pt_TREE));
	// Imprime uma previa da Arvore
	/*printf("\nA Arvore ficaria desta forma:\n");
	exibirArvore(pt_TREE);*/
	printf("\n");
	printf("\nNUMERO DE NOSH: %d\n", sizeof_Tree_BIN( pt_TREE) );
	deltree_TRUE( &pt_TREE );
	printf("\nA Arvore foi removida.\n");
	printf("\nNUMERO DE NOSH: %d\n", sizeof_Tree_BIN( pt_TREE) );

	return 1;
}