/*
  BOM MATERIAL
  http://www.inf.ufpr.br/cursos/ci067/Docs/NotasAula/notas-11_Fun_c_coes.html
 */

//void eh um default de tipo  vazio
#include<stdio.h>
#include <stdlib.h>
// DECLARACAO DAS FUNCOES ou PROTOTIPO
void oi( void )                           ; 
float calc_media( int vetor[] , int )     ;
void tudo_bem( char x[] )                 ;
void familia( void )                      ;
void sair( void )                         ;
int soma2(int  , int )                  ;
int le_int(void);

int main()
{
	int A, B;
	int continuar = 1;
	int var_vetor[] = {1,2,3,4,5,6,7,8,9};

    do // IMPORTANCIA ... fazer menu
    {
        printf("\n\tChat : C Progressivo.net\n\n");
        printf("1. Oi\n");
        printf("2. Tudo bem\n");
        printf("3. Como vai a familia\n");
        printf("4. Soma 2 numeros\n");
	    printf("5. Media numerica de um vetor\n");
        printf("0. Sair\n");

        scanf("%d", & continuar);
        system("clear");

        switch(continuar)
        {
	case 1:
		oi();
		break;

	case 2:
		{
		char STRING[] = "Oi String, tudo otimo, e com voce?";
        tudo_bem( STRING );
		break;
	    }

	case 3:
		familia();
		break;

	case 4:
		{ printf("\n\tDigite 2 numeros para somar: ");
          //scanf("%d %d", &A, &B);
          A = le_int();
          B = le_int();
          printf("\n\tA resposta eh: %d ", soma2(A , B) );
		  break;
		 }
	case 5:
		{ printf("\n\t Valor medio do Vetor ");
          int tam = (int)sizeof(var_vetor)/sizeof(int);
          printf("\n\tA resposta eh: %f ", calc_media(&var_vetor [0], tam));
		  break;
		 }


	case 0:
		sair();

	default:
		printf("Digite uma opcao valida\n");
} // fim do SWITCH
    } while(continuar); // encerrou com 0 ....
    
    return 1; // adicionado por CCS
}
/*******************************************************************/
void oi()
{
    printf("Oi!\n");
    return; // opcional
}
/*******************************************************************/
float calc_media ( int vetor[] , int TAM)
{
   float media = 0;
   for(int i=0; i < TAM; i++ )
   {
     media += vetor[i] ;
     printf(":\t %d", vetor[i]);
   }  
   media = media/TAM ;
   return(media);
 }  
/*******************************************************************/

void tudo_bem(char V[])
{ 
    printf("\n IMPRIMINDO DA FUNCAO: %s", V);
    return;
}
/*******************************************************************/

void familia()
{
    printf("Meus bits...digo, minha familia vai bem!\n");
    // sem RETURN
}
/*******************************************************************/

void sair()
{  // char letra;
   // letra = getchar();
    printf("Ja vai??? Nao! Nao! Espere! Naa...\n");
    //system("pause");
    //return 0;
    exit(0); // ABORT
}
/*******************************************************************/
int soma2(int x , int y)
{
   return( x+y );
}
/*******************************************************************/

 int le_int()
 { int x;
	
   printf(" DIGITE UM NUMERO INTEIRO ");
   //setbuf( stdin, NULL );
    //fflush(stdin); // quando se le caracter
    /* OU
     fflush(stdin);
    __fpurge(stdin);
  */
   scanf("%d ", & x );
   return (x);
  } 
/*******************************************************************/
