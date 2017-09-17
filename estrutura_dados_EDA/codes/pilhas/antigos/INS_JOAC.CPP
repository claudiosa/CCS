# include <conio.h>
# include <stdio.h>
# include <stdlib.h>
# include <ctype.h>

typedef struct duplas
   { int idade;
     struct duplas *next;
     struct duplas *prior;
   }modelo;

typedef modelo dupla;

void imp_lista2 (dupla *L);
int  busca_aleat (dupla *L, int i);
dupla *cria_no();
int le_valor();
void insere (int x, dupla *&L);

void main()
{

 int vetor [10]={1,2,3,4,5,6,7,8,9,10};
 int i, is;
 dupla *L;
 L=NULL;
 int MAX = (int)sizeof(vetor)/sizeof(int);
 for (i=0; i<MAX; i++)
  insere(vetor[i],L);
 imp_lista2(L);
 is=le_valor();
 is=busca_aleat(L, is);
 if (is<0)
  {
   printf ("\nValor nao encontrado");
   getch();
  }
 else
 {
  printf ("\n%i", is);
  getch();
 }
}

void insere(int x, dupla *&L)
{
 dupla *aux, *novo_no, *ultimo;
 aux=L;
 ultimo=L->prior;
 novo_no  = cria_no();
 if (aux==NULL)
  {
   novo_no->idade=x;
   novo_no->next=novo_no;
   novo_no->prior=novo_no;
   L=novo_no;
   return;
  }
  novo_no->idade=x;
  novo_no->next=L;
  ultimo -> next =   novo_no;
  novo_no ->  prior  = ultimo ;
  L->prior=novo_no;
  return;
}


dupla *cria_no()
{
 dupla *novo;
 if ((novo=(dupla *)malloc(sizeof(dupla)))==NULL)
  {
   printf ("Problema na alocacao!!");
   getch();
   exit(0);
  }
  return(novo);
}

void imp_lista2(dupla *L)
{
 int i=0;
 dupla *anc;
 anc=L;
 clrscr();
 for (; L->next!=anc; L=L->next)
  {
   printf ("\n No numero %d eh %d", i, L->idade);
   i++;
  }
   printf ("\n No numero %d eh %d", i, L->idade);
   getch();
}

int le_valor()
{
 int i;
 printf ("\n Digite o valor a procurar: ");
 scanf ("%d", &i);
 return(i);
}

int  busca_aleat(dupla *L, int i)
{
 int j=0;
 dupla *anc, *pt2;
 anc=L;
 pt2=L->prior;

 if (anc->next==pt2)
  {
   if (anc->idade==i)
      return(j);
   else
     return(-1);
  }

 for (; anc!=pt2; anc=anc->next)
  {
   if (anc->idade==i)
     return(j);
   else
     j++;
  }
  return(-1);
 }

