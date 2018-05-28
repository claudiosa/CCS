#include <stdio.h>
#include <stdlib.h>
#define TAM 50

#define MALLOC(a) (a*)malloc(sizeof(a))

typedef struct lista {
   int info;
   struct lista* prox;
} Lista;

Lista* lista_cria() {
   return NULL;
}

Lista* lista_insere (Lista* l, int i) {
   Lista* novo = MALLOC(Lista);
   novo->info = i;
   novo->prox = l;
        return novo;
}

void lista_imprime (Lista* l) {
   Lista* p;
   for (p = l; p != NULL; p = p->prox)
       printf("%d ", p->info);
}

Lista *inversao( Lista *l) {

        Lista *nova = lista_cria();
        Lista *p;

        for ( p = l; p; p = p->prox )
                nova = lista_insere(nova, p->info);
        return nova;
}

int main() {
   Lista* l;
   l = lista_cria();
   Lista* l2;
   l2 = lista_cria();
   Lista* l3;
   l3 = lista_cria();
   int i, n, cont=1;
   for(i=0;i<TAM;i++){
   	scanf("%d",&n);
    if(l==0 && n==-1){
      printf("-1");
      return 0;
    }
    if(n==-1){
      break;
    }
   	l=lista_insere(l,n);
   	l3=lista_insere(l3,n);
   }
   l=inversao(l);
   l3=inversao(l3);
   int maior=l->info;
   for(l=l;l!=NULL;l=l->prox){
     if(l->info>maior){
     	maior=l->info;
	 }
   }
   for(l3=l3;l3!=NULL;l3=l3->prox){
   	if(l3->info==maior){
   		l2=lista_insere(l2,cont);
	   }
	   cont++;
   }
   l2=inversao(l2);
   lista_imprime(l2);
   return 0;
}
