#include "lista_00.h"

int main(void)
{  
	system("clear");
	//char *entrada = NULL;
   char entrada [33];
	int i=0, N_NOMES;
	/*
   char *vetor_INPUT[] = 
		  {"joao", "pedro henrique", 
		   "anita", "maria luiza"};
    int Q = 4; 
    */
    //printf("\n VETOR %d elmentos\n", Q);		
	/** cria uma lista **/
    noh_tipo * L;
    L = cria_no(); // UM NOH COMPLETO FOI CRIADO
    printf("ENDERECOS: %p %p\n" , L -> next , L);
    printf("\n INICIAL: %s", L  -> nome );
    strcpy( L -> nome , "CABECA DE LISTA" );
    printf("\n DEPOIS: %s", L  -> nome );
    
    // APLICACAO
	//for(int i=0; i < Q; i++ )	
   
   //  while ((getline( &entrada, &len, stdin)) != -1)
  printf("\n QT. NOMES (int):"); 
  __fpurge(stdin);  
  fscanf(stdin, "%d", &N_NOMES);  
 //fflush(stdin); 
 //scanf("%22[^\n]s" , entrada ) != EOF )	
//while(fscanf(stdin,"%[a-z A-Z]s\n" , entrada ) != EOF )	
   while(i < N_NOMES)
	{ 
 	  printf("\n NOME: ");	
	  __fpurge(stdin);	
	  fgets(entrada , sizeof(entrada), stdin);
 	  //fscanf(stdin, "%[^\n]s", entrada);
 	  //scanf("%[a-z A-Z]s", entrada );
	  //insere_lista( vetor_INPUT[i] , L );
	  
	  printf("\n LIDO : %s",  entrada );
	  insere_lista( entrada , L );
	  //printf("\n : %s : %ld",  entrada , len);    
	  //printf("\n %d: %s ", i, vetor_INPUT[i] );    
	  //setbuf(stdin, NULL);
	  i++;
    };
		
	//printf("fim: %p %p\n", L->next, 	ancora->next );
	imp_lista( L );
	puts("\n... SUCESSO...");

return 1;
}

