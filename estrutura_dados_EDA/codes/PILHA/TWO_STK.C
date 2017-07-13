/* PROGRAMA DUAS ESTRUTURAS DE PILHA SOBRE UM VETOR */
#include<stdio.h>
#include<conio.h>
#include<stdlib.h>

#define MAX 5

typedef struct modelo
	{
	 int topo1;
	 int topo2;
	 char entradas[MAX];
	}pilha;

void leitura(char *x);
int vazia_1(pilha *p);
int vazia_2(pilha *p);
int cheia(pilha *p);
void empilha_1(char *x, pilha *p);
void empilha_2(char *x, pilha *p);
void desempilha_1(pilha *p);
void desempilha_2(pilha *p);
void show_1(pilha *p);
void show_2(pilha *p);


void main()
{
 pilha *p, Pilha_fisica;
 int op;
 char x;

 p = &Pilha_fisica;

 p->topo1=-1; /* uma celula atras da inicial */
 p->topo2=MAX; /* idem para final....*/

 do
  {
	printf("\n1 - INSERE NA PILHA1");
	printf("\n2 - INSERE NA PILHA2");
	printf("\n3 - REMOVE NA PILHA1");
	printf("\n4 - REMOVE NA PILHA2");
	printf("\n5 - IMPRIME TOPO1");
	printf("\n6 - IMPRIME TOPO2");
	printf("\n7 - SAIDA");

	printf("\n DIGITE A OPCAO: ");
	scanf("%d" , & op );

	switch (op)
		 {
	case 1:
			{leitura(&x);
			empilha_1(&x,p);		break;
			}
	case 2:
			{leitura(&x);
			empilha_2(&x,p);		break ;
			}

	case 3:{	desempilha_1(p);break;}
	case 4:{	desempilha_2(p);break;}
	case 5:{	show_1(p);break; }
	case 6:{ show_2(p);break; }
	case 7: exit(0);
		 }
  }while (op != 0 );
}
/***********************/
void leitura (char *x)
 { printf("\nDigite Letra::: ");
	 fflush(stdin);
	 *x = getche();
	 return;
 }
/***********************/
 void empilha_1(char *x, pilha *p)
{
 if (cheia(p))
	{
	 printf("\nA pilha 1 esta cheia");
	 getchar();
	 return;
	}
 ++(p->topo1);
 p->entradas[p->topo1] = *x;
 return;
}
/***********************/
void empilha_2(char *x, pilha *p)
{
 if (cheia(p))
	{
	 printf("\nA pilha 2 esta cheia");
	 getchar();
	 return;
	}
 --(p->topo2);
 p->entradas[p->topo2] = *x ;
 return;
}

void desempilha_1(pilha *p)
{
 if (vazia_1(p))
	{
	 printf("\nA pilha 1 esta vazia");
	 getchar();
	 return;
	}
	  /* *x = p->entradas[p->topo1]; *retorno  */
	 (p->topo1)--;
 return;
}
void desempilha_2(pilha *p)
{
 if (vazia_2(p))
	{
	 printf("\nA pilha 2 esta vazia");
	 getchar();
	 return;
	}
	/* *x = p->entradas[p->topo2];  ===> retornar algo */
	(p->topo2)++;
	return;
}

	int vazia_1 (pilha *p)
	{ return((p->topo1)<= -1);
	}

	int vazia_2(pilha *p)
	{ return((p->topo2) >= MAX);
	}

	int cheia(pilha *p)
	{  return ((p->topo1 + ( (-1) * ( p->topo2 - MAX )) ) >= MAX-1 );
	}

	void show_1(pilha *p)
	{   int ancora;

	 if (vazia_1(p))
	{ printf("\nA pilha 1 esta vazia");
	  getchar();
	  return;
	}
	 ancora=p->topo1;
	 while (p->topo1>=0)
		{
		 printf("\n\t%c",p->entradas[p->topo1]);
		 (p->topo1)--;
		}
	 p->topo1=ancora;
	 getche();
	 return;
	}

	void show_2(pilha *p)
	{
		 int ancora;

	 if (vazia_2(p))
		{
		 printf("\nA pilha 2 esta vazia ");
		 getchar();
		 return;
		}
	 ancora=p->topo2;
	 while (p->topo2<MAX)
		{
		 printf("\n\t%c",p->entradas[p->topo2]);
		 (p->topo2)++;
		}
	 p->topo2=ancora;
	 getche();
	 return;
	}

/**********************************/