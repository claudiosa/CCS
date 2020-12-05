// leitura e escrita TEXTO
#include <stdio.h>
#include <stdlib.h>
// #define NUM 2 COMENTADO AGORA
struct exemplo
{
	char nome[50];
	int idade;
};

int main(void){
   typedef  struct exemplo MEU_TIPO;
   MEU_TIPO registro;
    // apenas para fins didaticos
  
    char continua = 's';	       
    FILE *fptr;
//    int i; 
 /* ************************************************************/   
    fptr=fopen("file.txt","wt"); // abertura limpa em TXT
 /* ************************************************************/   
    while(continua == 's' || continua == 'S')
    {
	printf("Enter nome: ");
	scanf("%s" , registro.nome);
	printf("Enter idade: "); 
	scanf("%d",  &registro.idade); 
	// Escrevendo no ARQUIVO
	fprintf (fptr, "  %s" , registro . nome);
	fprintf (fptr, "  %d\n", registro . idade);
	printf("\n Deseja continuar (s/S) para SIM: ");
	getchar();
	scanf("%c",  &continua ); 
	//continua = getchar();
    }
    
    fclose(fptr);
/* ************************************************************/   
   
     // REABRINDO ARQUIVO
   fptr=fopen("file.txt","rt");
   if(fptr==NULL){
       printf("Erro na abertura ... confira o nome e o tipo do arquivo!");
       getchar();
       exit(1);
      }
/* ************************************************************/
// LENDO DO ARQUIVO TXT
    while( !feof(fptr) )  //o retorno é 0 ... negando 1
    {   
        fscanf(fptr, "%s" , registro.nome);
        fscanf(fptr, "%d\n",&registro.idade);
       // IMPRIME ANTES
        printf("\n Nome: %s\t idade: %d \n", registro.nome, registro.idade);
    }
/* ************************************************************/    
 // FINAL OK ?
    if ( !ferror(fptr) ) // retorno é 0 ... 
	printf("\n FIM DE ARQUIVO FOI ALCANCADO");
	else
	printf("\n HOUSTON, we have problems");
	
    fclose(fptr);
 }
/* ************************************************************/     