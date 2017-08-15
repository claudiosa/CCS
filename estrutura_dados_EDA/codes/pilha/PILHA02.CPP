# include <conio.h>
# include <stdio.h>
# include <ctype.h>
# include <stdlib.h>
# include <string.h>
# define MAX 10

typedef struct mod_pilha{
			 int topo;
			 char entradas[MAX];
			}pilha;

int pilha_cheia (pilha *P);
int push (char x, pilha *P);
void pop (char *x, pilha *P);
int pilha_vazia (pilha *P);
void inicializa_pilha (pilha *P);
void imprime (pilha *P);

/*empilhar push-P eh por referencia*/

int push (char x, pilha *P)
 {
  if (pilha_cheia(P))
   {
    printf ("\nA pilha estah cheia!");
    getche();
    return(1);
   }
  ++(P->topo);
  P->entradas[P->topo]=x;
  return(0);
 }

void pop (char *x, pilha *P)
 {
  if (pilha_vazia(P))
   {
    printf ("\n A pilha estah vazia!");
    getche();
    return;
   }
   *x=P->entradas[P->topo];
   (P->topo)--;
   return;
 }

int pilha_cheia (pilha *P)
{
 return((P->topo)>=MAX-1);
}

int pilha_vazia (pilha *P)
{
 return((P->topo)<=0);
}

void inicializa_pilha (pilha *P)
{
 P->topo=0;
 return;
}

void imprime (pilha *P)
{
 char x;
 clrscr();
 while (P->topo!=0)
 {
  pop(&x, P);
  printf ("\nO numero eh: %d", x);
 }
 getch();
}

void main()
{
 int y, vetor[]={1,2,3,4,5,6};
 char x;
 pilha *P;
 clrscr();
 int tam=(int)sizeof(vetor)/sizeof(int);
 inicializa_pilha(P);

 for (int KA=0; KA<tam; KA++)
   push(vetor[KA], P);

   imprime(P);
 }
