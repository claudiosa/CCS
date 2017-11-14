#include <stdio.h>
#include <stdlib.h>
//#include <stdbool.h> // bool no C

int f1(int *p)
 { 	return(*p = *p + 11);
 }

int f2(int **p)
 { 	//usa ** pois eh conteudo
 	return((**p) = (**p) + 22);
 }

int f3(int **p)
 { 	//usa ** pois eh conteudo
 	return((**p) = (**p) + 33);
 }


int main(void)
{
 system("clear");
 int a = 10;
 int *p1, **p2;
 p1 = &a;
 p2 = &p1;
 //(*p1)++;
 printf(" \nEnderecos a:%p | p1:%p | p2:%p ", &a, *f1, f2 ); //OU
 printf(" \nf1:a: %d ", f1(p1) ); //OU
 printf(" \nf2:a: %d ", f2(p2) ); //OU
 printf(" \nf2:a: %d ", f2(&p1) ); // este eh o caso utilizado
 printf(" \nf3:a: %d ", f3(p2) ); // este eh o caso utilizado
 
 //(**p2)++;
 //printf(" \na: %d ", a );
 return 1;
}