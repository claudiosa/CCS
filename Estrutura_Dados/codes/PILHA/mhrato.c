#include<conio.h>
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<mhlab.h>

void main()
{       int i=0,j,achou=0,A,B=2;
	char labir[12];
	person rato,ratotemp;
	clrscr();
	do
	{	gotoxy(30,5);
		printf("[1] N¡vel F cil");
		gotoxy(30,6);
		printf("[2] N¡vel Normal");
		gotoxy(30,7);
		printf("[3] N¡vel Dif¡cil");
		gotoxy(30,8);
		printf("[4] Desafio Especial");
		gotoxy(30,9);
		printf("[5] Outro");
		gotoxy(30,11);
		printf("Op‡Æo: ");
		scanf("%d",&i);
		switch(i)
		{	case 1:strcpy(labir,"labiresp.txt");break;
			case 2:strcpy(labir,"labir.txt");break;
			case 3:strcpy(labir,"labir3.txt");break;
			case 4:strcpy(labir,"labir2.txt");break;
			case 5:
			{	gotoxy(30,20);
				printf("Digite o nome do arquivo: ");
				fflush(stdin);
				gets(&labir);
			}
		}
	}while(i==0);
	Labirin(labir);
	Inicio();
	B=2;
	A=1;
	IniciaPilha();
	rato=IniciaPerson(rato);
	push(rato);
	do
	{       A=pilha.topo+1;
		if (rato.x>X)
		{	rato.x=X;}
		if (rato.y>Y)
		{	rato.y=Y;}
		if (pilha.topo>23)
		{	B=65;
			A=pilha.topo-23;
			if (pilha.topo>44)
			{	B=2;
				A=pilha.topo-44;
				if (pilha.topo>63)
				{	B=65;
					A=pilha.topo-63;
					if (pilha.topo>84)
					{	B=2;
						A=pilha.topo-84;
					}
				}
			}
		}
		gotoxy(rato.y+20,rato.x+8);
		textcolor(7);
		cprintf("©");
		if (pilha.topo>1)
		{	gotoxy(ratotemp.y+20,ratotemp.x+8);
			cprintf(" ");
		}
		gotoxy(B,A);
		cprintf("%d,%d",pilha.vetorx[pilha.topo],pilha.vetory[pilha.topo]);
		if ((rato.x==X)&&(rato.y==Y))
		{	gotoxy(B,A);
			cprintf("ACHOU!!!");
			achou=1;
		}
		ratotemp=rato;
		rato=Proxima(rato);
		getch();
	}while(achou!=1);
	clrscr();
}



