/*Academico: Edesio Gobetti Schemes Junior
	     Jefferson A Bornhausen
	     Joaquim Cabral da Maia Neto
DAD-I => Estacionamento*/

#include<conio.h>
#include<stdio.h>
#include<ctype.h>
#include<stdlib.h>

#define MAX 25

typedef struct estr_pilha
		{ int topo;
		  char entradas[MAX];
		} pilha;

//Prototipando as funcoes.
void inicializa_pilha(pilha *P);
int pilha_vazia(pilha *P);
int pilha_cheia(pilha *P);
void push(char X, pilha *P);
void pop(char *X, pilha *P);
void mostra_pilha(pilha *P, pilha *L);
void ler(pilha *P, char &aux);

void main()
{
	char aux;
	pilha *P, *L;

	pilha pilha_real;
	P=&pilha_real;
	char vetor[]="abcdefghijlmnopqrst";
	int tam, i;
	inicializa_pilha(P);
	inicializa_pilha(L);
	tam=(int)sizeof(vetor)/sizeof(char);
	for(i=0; i<tam; i++)
	  push(vetor[i], P);
	ler(P, aux);
	mostra_pilha(P, L);
	getch();
}

//Esta funcao eh responsavel pela leitura de um item a ser retirado da pilha
void ler(pilha *P, char &aux)
{
	char item;
	int achou=0, temp;
	pilha *L;

	inicializa_pilha(L);
	clrscr();
	mostra_pilha(P, L);
	printf("\nDigite o item a ser retirado: ");
	fflush(stdin);
	scanf("%c",&item);
	temp=L->topo;
	while(L->topo!=0)
	{ pop(&aux, L);
	  if(aux==item)
		achou=1;
	  if(achou==0)
		push(aux, P);
	  achou=0;
	}
//Se temp for igual a P->topo significa que o item nao foi retirado, ou seja,
//nao foi encontrado.
	if(temp==P->topo)
	{ printf("\nItem nao cadastrado");
	  getch();
	}
}

//Esta funcao se encarrega de empilhar um item novo na pilha,esse empilhamento
//se da sempre no topo da pilha.
void push(char X, pilha *P)
{
	if(pilha_cheia(P)==1)
	{ clrscr();
	  printf("\nA pilha esta cheia");
	  getch();
	  return;
	}
	else
	{ ++(P->topo); /*eh a mesma coisa que: P->topo=P->topo+1*/
	  P->entradas[P->topo]=X;
	}
	return;
}

//Esta funcao se encarrega de desempilhar um item da pilha,esse desempilhamento
//se da sempre do item do topo da pilha.
void pop(char *X, pilha *P)//recuperando o valor do topo da pilha
{
	if(pilha_vazia(P))
	{ clrscr();
	  printf("\nA pilha esta vazia");
	  getch();
	  return;
	}
	else
	{ *X=P->entradas[P->topo];
	  (P->topo)--;
	}
	return;
}

//Indica se a pilha esta cheia
int pilha_cheia(pilha *P)
{
	return((P->topo)>=MAX-1);//retorna "1" se essa situacao for verdadeira.
}

//Indica se a pilha esta vazia
int pilha_vazia(pilha *P)
{
	return((P->topo)<=0);//retorna "1" se a pilha estiver vazia.
}

//Inicializa o topo de uma pilha com 0(zero).
void inicializa_pilha(pilha *P)
{
	P->topo=0;//convensao: desperdicando entrada[0].
	return;
}

//Essa funcao mostra os itens da pilha, se atendo ao fato de que nessa operacao
//o ponteiro X->topo (onde X indica o nome do ponteiro) eh decrementado perdendo
//o inicio da pilha. Para evitar isso, a maneira que eh desempilhado um item da
//pilha automaticamente eh empilhado em outra pilha auxiliar. O unico problema
//dessa operacao eh que os itens ficam invertidos.
void mostra_pilha(pilha *P, pilha *L)
{
	char aux;

	printf("\nItens:\n");
	while(P->topo!=0)
	{ pop(&aux, P);
	  printf("| %c |",aux);
	  push(aux, L);
	}
	return;
}
