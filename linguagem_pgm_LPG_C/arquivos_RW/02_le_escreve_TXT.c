// leitura e escrita TEXTO
#include <stdio.h>
#include <stdlib.h>
#define NUM 4
struct exemplo
{
	char nome[50];
	int idade;
};

int main(void){
   typedef  struct exemplo MEU_TIPO;
   MEU_TIPO 
             a[NUM], // para leitura do teclado
             b[NUM]; // para escrita na tela
	     // apenas para fins didaticos
	       
    FILE *fptr;
    int i;
  /* 
    fptr=fopen("file.txt","wt"); // abertura limpa em TXT
    for(i=0;i< NUM ;++i)
    {
        fflush(stdin);
        printf("Enter nome: ");
        scanf("%s" , a[i].nome);
        printf("Enter idade: "); 
        scanf("%d",  &a[i].idade); 
	// Escrevendo no ARQUIVO
	fprintf (fptr, "  %s" , a[i].nome);
	fprintf (fptr, "  %d\n", a[i].idade);
    }
    fclose(fptr);
 */
     // lendo a estrutura TODA
   fptr=fopen("file.txt","rt");
   if(fptr==NULL){
       printf("Erro na abertura ... confira o nome e o tipo do arquivo!");
       getchar();
       exit(1); // stdlib ... eh para esta funcao
      }

// LENDO DO ARQUIVO TXT
    for(i=0;i < NUM;++i)
    {
        fscanf(fptr, "%s" , b[i].nome);
        fscanf(fptr, "%d\n",&b[i].idade); 
        printf("nome: %s\t idade: %d \n",b[i].nome,b[i].idade);
    }
 
    fclose(fptr);
 }