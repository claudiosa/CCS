# include <conio.h>
# include <stdio.h>
# include <ctype.h>
# include <stdlib.h>
# include <string.h>
# define MAX 100

typedef struct mod_pilha{
			 int topo;
			 char entradas[MAX];
			}pilha;

int pilha_cheia (pilha *P);
char push (char x, pilha *P);
void pop (char *x, pilha *P);
int pilha_vazia (pilha *P);
void inicializa_pilha (pilha *P);
void conta (pilha *P);
void imprime(pilha *P);
/*empilhar push-P eh por referencia*/

char push (char x, pilha *P)
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
{pilha *j;
 j=P;
 int i=0;
 char x;
 clrscr();
 printf("\nA expressao eh:");
 while (i<= j->topo)
 {
  printf (" %c ",j->entradas[i]);
  i++;
 }

}


void conta (pilha *P)
{ int i=0;
 char x;
 while (P->topo!=0)
 {
  pop(&x, P);
  if(x=='(')
  i++;
  if(x==')')
  i--;
 }
  if(i==0)
  {
   printf ("\nA expressao estah correta!");
   getch();
   return;
  }
  if(i>0)
  {
   printf("\nEsta faltando fechar %d parenteses",i);
   getch();
   return;
  }
  else
  {
   printf("\nEsta sobrando  %d parenteses",-i);
   getch();
   return;
  }


 //getch();
}

void main()
{
 char x,vet[]="((1+2)*2";
 pilha *P;
 clrscr();
 int tam=(int)sizeof(vet)/sizeof(char);
 inicializa_pilha(P);

 for (int KA=0; KA<tam; KA++)
   push(vet[KA], P);

   imprime(P);
   conta(P);
 }
