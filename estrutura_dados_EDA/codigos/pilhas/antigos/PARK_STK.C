//PROGRAMA DO ESTACIONAMENTO
#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<string.h>
#include<time.h>
#include<malloc.h>
#define MAX 9

typedef struct modelo
	{
	 int topo1;
	 int topo2;
	 int placa[MAX];
	}pilha;

int procura (int *x, pilha *p);
int vazia(pilha *p);
int cheia(pilha *p);
int posicao(int *x, pilha *p);
void leitura(int *x);
void mostra(pilha *p);
void remove1(int *x, pilha *p);
void insere(int *x, pilha *p);

void main()
{
 pilha *p , ESTACIONAMENTO;
 int op;
 int *x, aux;
 x = & aux;
 p  = & ESTACIONAMENTO;

 p->topo1=-1;
 p->topo2=MAX-1;

 do
  {
	clrscr();
	printf("\n1 - ESTACIONA");
	printf("\n2 - RETIRA");
	printf("\n3 - MOSTRA OS CARROS");
	printf("\n7 - SAIDA");
   printf("\n=======================");
	printf("\n    Digite a opcao:::  ");
	scanf("%d",&op);
	switch (op)
		 {
		case 1:leitura(x);insere(x,p);break;
		case 2:leitura(x);remove1(x,p);break;
		case 3:mostra(p);break;
		case 7: exit(0);
		 }
  }	while ( op !=0 );
}

void leitura (int *x)
{ printf("\nDigite a Placa::: ");
	scanf("%d",x);
	 return;
}

void remove1(int *x, pilha *p)
{
 int i,ancora;
 if (vazia(p))
	{
	 printf("\nA pilha esta vazia");
	 getch();
	 return;
	}
 i=procura(x,p);
 if (i==-1)
	{
	 printf("\nCarro nao encontrado");
	 getch();
	 return;
	}
 ancora=p->topo1;
 while (p->topo1>i)
		{
		 p->placa[p->topo2] = p->placa[p->topo1];
		 (p->topo2)--;
		 (p->topo1)--;
		}
 while (p->topo1<ancora)
		{
		 (p->topo2)++;
		 p->placa[p->topo1]=p->placa[p->topo2];
		 (p->topo1)++;
		}
 (p->topo1)--;
 return;
}

int vazia(pilha *p)
{
 return((p->topo1)<0);
}

int cheia(pilha *p)
{
 return ((p->topo1)>=(MAX/2)-1);
}
void insere(int *x, pilha *p)
{
 if (cheia(p))
	{
	 printf("\nA pilha esta cheia");
	 getch();
	 return;
	}
 (p->topo1)++;
  p->placa[p->topo1]=*x;
 return;
}

void mostra(pilha *p)
{
 int ancora;
 clrscr();
 if (vazia(p))
	{
	 printf("\nA pilha esta vazia");
	 getch();
	 return;
	}
 ancora=p->topo1;
 while (p->topo1>=0)
		{
		 printf("\n%d",p->placa[p->topo1]);
		 (p->topo1)--;
		}
 p->topo1=ancora;
 getch();
 return;
}
int procura (int *x, pilha *p)
{
 int ancora,u;
 ancora=p->topo1;
 while (p->topo1>-1)
		{
		 if (p->placa[p->topo1]==*x)
	 {
	  u=p->topo1;
	  p->topo1=ancora;
	  return(u);
	 }
		 (p->topo1)--;
		}
 p->topo1=ancora;
 return(-1);
}
/**************************/