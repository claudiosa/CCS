//void eh um default de tipo  vazio
#include<stdio.h>
#include <stdlib.h>
#include <stdio_ext.h>
// DECLARACAO DAS FUNCOES ou PROTOTIPO
void alo (void);
int le_int(void);
// 'int' é o tipo de retorno da funcao
// soma é nome da função
// x e y são os parâmetros da função
int soma( int x , int y )                  
{    
	int z = x + y;  // corpo da função
	return z; // valor de retorno da função
	// DEVE SER IGUAL AO TIPO DA FUNCAO
}	
int main( void )
{
  system( "clear" ); // chama uma funcao para limpeza de tela
  printf("\n Resultado de soma %d\n", soma( 4, 5 ));
  printf("\n Resultado de soma %d\n", soma( 14, 15 )); // reusei aqui
  int x , y ;
  x = le_int();
  y = le_int();
  printf("\n Resultado de soma %d\n", x+y); 
  printf("\n =================== \n");
  alo();
 return 1;
}

 int le_int(void)
 { int x;
	
   printf(" DIGITE UM NUMERO INTEIRO: \a");
   //setbuf( stdin, NULL );
 
   scanf("%d\r", & x ); // le do teclado
  // getchar();
    fflush(stdin);     // limpeza  do BUFFER teclado
   __fpurge(stdin);    // remove 
  
   
   return (x);
} 



void alo (void)
  {
    printf("\n OI TUDO TERMINOU BEM \n");
    return;
  } 
