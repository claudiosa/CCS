
//O programa passou a ficar com problema e não sei o motivo, mas a lógica está lá em baixo:

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>


typedef struct {

    int head;
    int *array;
    int index;
    int topo;
} Pilha;



typedef struct {

  int *fila;
  int rear;
  int front;
  int entrada;
  int u;
  int capacidade;
  } Fila;

void push(Pilha *, int);
void pop(Pilha *);
int empty(Pilha *);
Pilha * criar_pilha (Pilha*, int);
void chegada ( int x, Fila * F );
void partida ( Fila * F );


int main(void){
    int i; int count = 0; int a = 0; int b = 0; int temp =0; int temp2 = 0; int maior = 0;
    int basinga = 0;
    scanf("%d", &temp);
    Pilha *p = NULL;
    p = criar_pilha(p,temp);
    Pilha *p2 = NULL;
    p2 = criar_pilha(p2,temp);


    Fila *fila = (Fila*)malloc(sizeof(Fila));
    fila->fila = (int*)malloc (sizeof(int) * temp);
    fila->capacidade = temp;
    fila->front= -1;


    for (i = 0; i<temp; i++){ // mandar todos os valores pra primeira pilha;
      scanf("%d", &temp2);
      push(p, temp2);
    }


    push(p2, p->topo); // mandar o primeiro valor para a pilha 2;
    pop(p);


    while(basinga==0){ //repetir até break;
      if(p2->head>-1){ // se a segunda pilha for maior que vazio
        if ((p->topo)>(p2->topo) || (p->head!=-1 && p2->head==-1)){ // se o valor da primeira pilha for maior que a segunda ou o índice da primeira for diferente de -1
          //e o índice da segunda for -1;
          //enviar pra segunda
          push(p2,p->topo);
          printf("%d ", p2->array[p->head]);
          pop(p);
        }
        else if(p->topo<=p2->topo){ // se o valor da primeira pilha for menor ou igual ao valor da segunda,
          //enviar pra fila
          chegada(p2->topo, fila);
          pop(p2);
        }
      }
      if(p2->head==-1 && p->head==0){//se a segunda pilha for vazia
        chegada(p->topo,fila);
        pop(p);
        break;
      }


    }

  for(i=0; i<temp; i++){
      printf("%d ", fila->fila[i]);
  }




    return 0;
}





void push (Pilha *p, int c){
    p->head++;
    p->array[p->head]= c;
    p->topo = p->array[p->head];


}

Pilha * criar_pilha (Pilha *p, int tam){

    p = (Pilha*) malloc(sizeof(Pilha));
    p->index = tam;
    p->array = (int *)malloc(sizeof(int) * tam);
    p->head = -1;
    return p;

}

void pop (Pilha *p){
        p->head--;
        p->topo = p->array[p->head];

}

int empty_pilha (Pilha *p){
    if (p->head>=0){
        return 1;
    }
    return 0;
}


void chegada ( int x, Fila * F ){

  F-> entrada = x;
  if (F->front != F->rear){
    F->front++;
    F->fila[F->front] = x;
  }

}

void partida ( Fila * F ){
    F->front++;
    F->fila[F->front] = 0;

     //retorno = F -> entrada [ F -> front ];

}
