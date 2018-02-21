// leitura e escrita TEXTO
#include <stdio.h>
#include <stdlib.h>
#define NUM 2
struct exemplo
{
	char nome[50];
	int idade;
};

int main(void){
   typedef  struct exemplo MEU_TIPO;
   MEU_TIPO registro;
	     // apenas para fins didaticos
	       
    FILE *fptr;
    int i;
    fptr=fopen("file.txt","at"); // abertura limpa em TXT
    for(i=0;i< NUM ;++i)
    {
        fflush(stdin);
        printf("Enter nome: ");
        scanf("%s" , registro.nome);
        printf("Enter idade: "); 
        scanf("%d",  &registro.idade); 
	// Escrevendo no ARQUIVO
	fprintf (fptr, "  %s" , registro . nome);
	fprintf (fptr, "  %d\n", registro . idade);
    }
    fclose(fptr);
     // lendo a estrutura TODA
   fptr=fopen("file.txt","rt");
   if(fptr==NULL){
       printf("Erro na abertura ... confira o nome e o tipo do arquivo!");
       getchar();
       exit(1);
      }

// LENDO DO ARQUIVO TXT
    for(i=0;i < NUM;++i)
    {
        fscanf(fptr, "%s" , registro.nome);
        fscanf(fptr, "%d\n",&registro.idade); 
        printf("nome: %s\t idade: %d \n", registro.nome, registro.idade);
    }
 
    fclose(fptr);
 }