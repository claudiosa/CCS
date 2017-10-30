/* ROBERTO NOVAKOSKY
 * UDESC - UNIVERSIDADE DO ESTADO DE SANTA CATARINA
 * FEJ - FACULDADE DE ENGENHARIA DE JOINVILLE
 * CURSO DE PROCESSAMENTO DE DADOS
 * TERCEIRA FASE - SEGUNDO SEMESTRE 1997
 * DISCIPLINA: DAD
 * OPERACOES BASICAS COM ARVORES VINARIAS
 * Utilizacao de funcoes NAO recursivas
 */

#include <stdio.h> //FILE
#include <iostream.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <malloc.h>

// ESTRUTURA
typedef struct arvore { int valor;
			struct arvore *esq;
			struct arvore *dir;
		      } *pont;

// PROTOTIPOS
pont maketree(int number);        //auxiliar da inclui_no
void setdir(pont &p, int number); //auxiliar da inclui_no
void setesq(pont &p, int number); //auxiliar da inclui_no
void imprime(pont &inicio); //versao recursiva
void tela_menu();
void inclui_no(pont &inicio); //versao NAO recursiva
void deleta_no(pont &inicio); //versao NAO recursiva
void deldir(pont &pai, pont &filho);  //auxiliar da deleta_no
void delesq(pont &pai, pont &filho);  //auxiliar da deleta_no


void main()
{
  pont tree = 0;
  int number;
//********************** menu geral padrao p/exercicios ******
 char opcao; opcao = '1';
 tela_menu();
 while (opcao !='6')
  {opcao = getche();
   switch (opcao)
     {case   0:  //digitada funcao
		getch(); //pega buffer
		break;
      case '1': inclui_no(tree);
		tela_menu();
		break;
      case '2': deleta_no(tree);
		tela_menu();
		break;
      case '3': imprime(tree);
		if (!getch()) getch();
		tela_menu();
		break;
      case '4': gotoxy (3, 23); printf("4 - Opcao nao ativada");
		gotoxy(10,17);
		break;
      case '5': gotoxy (3, 23); printf("5 - Opcao nao ativada");
		gotoxy(10,17);
		break;
      case '6': // encerra while
		break;
      default: gotoxy(3,23); printf("Opcao invalida           ");
	       gotoxy(10,17);
     }
  }
//***************** fim menu geral padrao p/exercicios **************
}//fim main()


//************* tela do menu simples p/ exercicios ******************
//*******************************************************************
void tela_menu()
{ clrscr();
  gotoxy(3, 7); printf("Menu");
  gotoxy(3, 9); printf("1 - Inclui noh");
  gotoxy(3,10); printf("2 - Deleta noh");
  gotoxy(3,11); printf("3 - Imprime nos");
  gotoxy(3,12); printf("4 - Nao ativada");
  gotoxy(3,13); printf("5 - Nao ativada");
  gotoxy(3,14); printf("6 - Fim");
  gotoxy(3,17); printf("Opcao: ");
}
//********************************************************************
//********************************************************************

void inclui_no(pont &inicio)  //versao nao recursiva
{clrscr();
 pont pai, filho;
 int number;
 printf("Digite valor: ");
 scanf("%i", &number);

 if (inicio == 0)   //arvore vazia
    { inicio = maketree(number);
    }
 else
    {pai = filho = inicio;
     while (filho != NULL)
	{ pai = filho;  //porque filho sera alterado e preciso deste end
			//que serah pai do novo filho
	  if (number > (pai->valor) )
		filho = filho->dir;
	  else
		filho = filho->esq;
	}
     if (number > (pai->valor) )
	setdir(pai, number);
     else
	setesq(pai, number);
    }

}
// ***********************************************************

void imprime(pont &inicio)   //versao recursiva
{if(inicio != 0)
  {
    imprime(inicio->esq);
    printf( "\n%d",inicio->valor);
    imprime(inicio->dir);
  }
}

void setdir(pont &p, int number)
{p->dir = maketree(number);

}

void setesq(pont &p, int number)
{p->esq = maketree(number);

}

//******************************************************************
pont maketree(int number)
{pont aux;
 aux = (struct arvore *)malloc(sizeof(struct arvore));
 if (!aux)
   {printf("Sem memoria para incluir no.\n");
   }
 else
   { aux->esq = 0;
     aux->dir = 0;
     aux->valor = number;
     return(aux);
   }
}
//******************************************************************
void deleta_no(pont &inicio)  //versao nao recursiva
{pont pai, filho; pai = filho = inicio;
 int number;
 clrscr();
 printf("Qual valor deletar? ");
 scanf ("%d", &number);


 int chave = 1;
 if (!inicio)    //mesma coisa que: if (inicio == 0)
   {printf("Arvore Vazia");
   }
 else
   {if (pai->valor == number)   //deletar o inicio da arvore
      {if ( (pai->esq != 0) && (pai->dir != 0) )
	  {pai = pai->esq;
	   while (pai->dir != 0)
	     {pai = pai->dir;
	     }
	   pai->dir = filho->dir;
	   free(filho); inicio = pai;
	  }
	else if (pai->esq != 0)
	  {inicio = pai->esq;
	   free(pai);
	  }
	else if (pai->dir != 0)
	  {inicio = pai->dir;
	   free(pai);
	  }
	else  //arvore c/so um elemento
	  {inicio = 0;
	   free(pai);
	  }
      }
   else
      {while (chave)
	{pai = filho;
	 if (number > pai->valor)
	    {filho = pai->dir;
	     if (!filho)  //nao encontrado valor
	       chave = 0;
	     else if (filho->valor == number)
	       {chave = 0; deldir(pai, filho);
	       }
	     }
	 else
	     {filho = pai->esq;
	      if (!filho)  //nao existe o valor procurado
		 chave = 0;
	      else if (filho->valor == number)
		 {chave = 0; delesq(pai, filho);
		 }
	      }
	}//fim while
      }
    }
}// fim

//***********************************************************
void deldir(pont &pai, pont &filho)
{
 if (filho->dir == filho->esq)
   {pai->dir = 0; free(filho);
   }
 else if (filho->dir == 0)
   {pai->dir = filho->esq; free(filho);
   }
 else if (filho->esq == 0)
   {pai->dir = filho->dir; free(filho);
   }
 else //senao existe filho->esq e tambem filho->dir
   {pai->dir = filho->dir;
    pont aux;
    aux = filho->dir;
    while (aux->esq != 0)
      aux=aux->esq;
    aux->esq = filho->esq;
    free(filho);
   }
}
//***********************************************************
void delesq(pont &pai, pont &filho)
{if (filho->esq == filho->dir)
  {pai->esq = 0; free(filho);
  }
 else if (filho->esq == 0)
  {pai->esq = filho->dir; free(filho);
  }
 else if (filho->dir == 0)
  {pai->esq = filho->esq; free(filho);
  }
 else
  {pai->esq = filho->dir;
   pont aux; aux = filho->dir;
   while (aux->esq != 0)
      aux = aux->esq;
   aux->esq = filho->esq;
   free(filho);
   }
}
//**************************************************************






