#include<stdio.h>
#include<stdlib.h>



int main(){
	//int vetor[10];
	int tamanho = 0;
	int *vetor = NULL;
	int i;

	printf("Informe o tamanho do vetor\n");
	scanf("%d", &tamanho);

	vetor = (int *)malloc(tamanho * sizeof(int));
	if(vetor == NULL){
		printf("Erro alocando memória\n");
		return 1;
	}
	srand(time(NULL));
	for(i = 0; i < tamanho; i++){
		printf("Informe o valor da posição %d\t", i);
		//scanf("%d", &vetor[i]);
		vetor[i] = (rand()%1000)+1;
	}
	printf("Você informou\n");
	for(i = 0; i < tamanho; i++){
		printf("%d\n", *(vetor + i));
	}
	free(vetor);
	vetor = NULL;
	return 0;
}
