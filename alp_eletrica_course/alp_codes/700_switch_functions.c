
#include<stdio.h>
#include <stdlib.h>
void oi( void );
float calc_media( int vetor[] , int );
void tudo_bem( void );
void familia( void );
int sair( void );
int soma2(int x , int y);

int main()
{
    int A, B;
    int continuar=1;
    int var_vetor[] = {1,2,3,4,5,6,7,8,9};
    
    do
    {
        printf("\n\tChat : C Progressivo.net\n\n");
        printf("1. Oi\n");
        printf("2. Tudo bem\n");
        printf("3. Como vai a familia\n");
        printf("4. Soma 2 numeros\n");
	printf("5. Media numerica de um vetor\n");
        printf("0. Sair\n");

        scanf("%d", &continuar);
        system("clear");

        switch(continuar)
        {
            case 1:
                oi();
                break;

            case 2:
                tudo_bem();
                break;

            case 3:
                familia();
                break;

            case 4:
                { printf("\n\tDigite 2 numeros para somar: ");
		   scanf("%d %d", &A, &B);
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
                continuar = sair();
                break;

            default:
                printf("Digite uma opcao valida\n");
        }
    } while(continuar); // encerrou com 0 ....
    
    return 1; // adicionado por CCS
}
/*******************************************************************/
void oi()
{
    printf("Oi!\n");
}

float calc_media ( int vetor[] , int TAM)
{
   float media = 0;
   for(int i=0; i < TAM; i++ )
   {
     media += vetor[i] ;
    // printf(":\t %f", media);
   }  
       media = media/TAM ;
   return(media);
 }  
 
 void tudo_bem()
{
    printf("Tudo otimo, e com voce?\n");
}

void familia()
{
    printf("Meus bits...digo, minha familia vai bem!\n");
}

int sair()
{  //char letra;
    //letra = getchar();
    printf("Ja vai??? Nao! Nao! Espere! Naa...\n");
    system("pause");
    return 0;
}

int soma2(int x , int y)
{
   return(x+y);
}
 