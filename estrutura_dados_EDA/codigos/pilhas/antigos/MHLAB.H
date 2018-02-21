//Para usar as fun‡äes de "mhlab.h", deve-se declarar uma vari vel person
//dentro do main. Vocˆ tamb‚m pode-se utilizar das vari veis globais X e Y
//que sÆo as dimensäes do labirinto lido do arquivo texto pela fun‡Æo
//void Labirin(). A matriz global labirinto[2][MAX][MAX], ‚ uma matriz
//texto que cont‚m o labirinto lido do arquivo texo. A vari vel global
//pilha pode ser acessada do main assim como as suas vari veis internas
//(topo, vetorx[MAX] e vetory[MAX]).

#define MAX 100

typedef struct {int x,y;}person;
typedef struct {int topo, vetorx[MAX], vetory[MAX];}Lpilha;

void Inicio();
void Labirin();
int Teste(int ratox,int ratoy, int vetorx, int vetory, int vetorx2, int vetory2);
person pop();
void push(person temp);
void IniciaPilha();
person IniciaPerson(person rato);
void DesenhaLab();
person Proxima(person rato);

int X,Y,labirinto[MAX][MAX];
Lpilha pilha;

void Inicio()
{       int i,j;
	clrscr();
	textcolor(2);
	gotoxy(25,2);
	cprintf("MH-LABIRINTO: PROGRAMA DO RATINHO");
	DesenhaLab();
	textcolor(14);
	gotoxy(Y+20,X+8);
	cprintf("*");
}

void Labirin(char labir[12])
{       FILE *teste;
	char temp[2];
	int i=0,j=0;
	char c[2];
	teste=fopen(labir,"r");
	temp[0]=getc(teste);
	switch(temp[0])
	{	case '1':labirinto[i][j]=1;break;
		case '0':labirinto[i][j]=0;
	}
	j++;
	while(!feof(teste))
	{	temp[0]=getc(teste);
		switch(temp[0])
		{	case '\n':{j=-1;i++;break;}
			case '1':{labirinto[i][j]=1;break;}
			case '0':{labirinto[i][j]=0;}
		}
		j++;
	}
	fclose(teste);
	X=i-1;
	Y=j-3;
}

int Teste(int ratox,int ratoy, int vetorx, int vetory,int vetorx2, int vetory2)
{	if (((ratox==vetorx)&&(ratoy==vetory))||((ratox==vetorx2)&&(ratoy==vetory2)))
	{	return(1);
	}
	else
	{	return(0);
	}
}

person pop()
{       person temp;
	temp.x=pilha.vetorx[pilha.topo];
	temp.y=pilha.vetory[pilha.topo];
	pilha.topo--;
	return(temp);
}

void push(person temp)
{	pilha.topo++;
	pilha.vetorx[pilha.topo]=temp.x;
	pilha.vetory[pilha.topo]=temp.y;
}

void IniciaPilha()
{       int i,j;
	for(i=0;i<100;i++)
	{	pilha.vetorx[i]=0;
		pilha.vetory[i]=0;
	}
	pilha.topo=0;
}

person IniciaPerson(person rato)
{	rato.x=1;
	rato.y=1;
	return(rato);
}

void DesenhaLab()
{       int i,j,parede=0;
	textcolor(3);
	for(i=0;i<X+2;i++)
	{	for(j=0;j<Y+2;j++)
		{	switch(labirinto[i][j])
			{	case 1:{gotoxy(j+20,i+8);cprintf("±");parede++;break;}
				case 0:{gotoxy(j+20,i+8);cprintf(" ");}
			}
		}
	}
	gotoxy(35,3);
	cprintf("PAREDES: %d",(parede-(2*X+2*Y)));
}

person Proxima(person rato)
{       int preso=1,posit=0,A;
	labirinto[rato.x][rato.y]=1;
	switch(labirinto[rato.x+1][rato.y+1])
	{	case 0:
		{	A=Teste(rato.x+1,rato.y+1,pilha.vetorx[pilha.topo-1],pilha.vetory[pilha.topo-1],pilha.vetorx[pilha.topo-2],pilha.vetory[pilha.topo-2]);
			if (A==0&&posit==0)
			{       rato.x++;
				rato.y++;
				push(rato);
				preso=0;
				posit=1;
			}
		}
		default:
		{ 	switch(labirinto[rato.x+1][rato.y])
			{	case 0:
				{	A=Teste(rato.x+1,rato.y,pilha.vetorx[pilha.topo-1],pilha.vetory[pilha.topo-1],pilha.vetorx[pilha.topo-2],pilha.vetory[pilha.topo-2]);
					if (A==0&&posit==0)
					{       rato.x++;
						push(rato);
						preso=0;
						posit=1;
					}
				}
				default:
				{	switch(labirinto[rato.x][rato.y+1])
					{	case 0:
						{	A=Teste(rato.x,rato.y+1,pilha.vetorx[pilha.topo-1],pilha.vetory[pilha.topo-1],pilha.vetorx[pilha.topo-2],pilha.vetory[pilha.topo-2]);
							if (A==0&&posit==0)
							{       rato.y++;
								push(rato);
								preso=0;
								posit=1;
							}
						}
						default:
						{       switch(labirinto[rato.x][rato.y-1])
							{	case 0:
								{	A=Teste(rato.x,rato.y-1,pilha.vetorx[pilha.topo-1],pilha.vetory[pilha.topo-1],pilha.vetorx[pilha.topo-2],pilha.vetory[pilha.topo-2]);
									if (A==0&&posit==0)
									{       rato.y--;
										push(rato);
										preso=0;
										posit=1;
									}
								}
								default:
								{	switch(labirinto[rato.x-1][rato.y])
									{	case 0:
										{	A=Teste(rato.x-1,rato.y,pilha.vetorx[pilha.topo-1],pilha.vetory[pilha.topo-1],pilha.vetorx[pilha.topo-2],pilha.vetory[pilha.topo-2]);
											if (A==0&&posit==0)
											{       rato.x--;
												push(rato);
												preso=0;
												posit=1;
											}
										}
										default:
										{	switch(labirinto[rato.x-1][rato.y+1])
											{	case 0:
												{	A=Teste(rato.x-1,rato.y+1,pilha.vetorx[pilha.topo-1],pilha.vetory[pilha.topo-1],pilha.vetorx[pilha.topo-2],pilha.vetory[pilha.topo-2]);
													if (A==0&&posit==0)
													{       rato.x--;
														rato.y++;
														push(rato);
														preso=0;
														posit=1;
													}
												}
												default:
												{	switch(labirinto[rato.x+1][rato.y-1])
													{	case 0:
														{	A=Teste(rato.x+1,rato.y-1,pilha.vetorx[pilha.topo-1],pilha.vetory[pilha.topo-1],pilha.vetorx[pilha.topo-2],pilha.vetory[pilha.topo-2]);
															if (A==0&&posit==0)
															{       rato.x++;
																rato.y--;
																push(rato);
																preso=0;
																posit=1;
															}
														}
														default:
														{	switch(labirinto[rato.x-1][rato.y-1])
															{	case 0:
																{	A=Teste(rato.x-1,rato.y-1,pilha.vetorx[pilha.topo-1],pilha.vetory[pilha.topo-1],pilha.vetorx[pilha.topo-2],pilha.vetory[pilha.topo-2]);
																	if (A==0&&posit==0)
																	{       rato.x--;
																		rato.y--;
																		push(rato);
																		preso=0;
																		posit=1;
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	if (preso==1)
	{       rato=pop();
	}
	return(rato);
}




