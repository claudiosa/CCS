#include <stdio.h>
#include <stdlib.h>
// #include <string.h>

char * le_uma_entrada (  void );
void imprime_entrada ( char * pt_vetor );

int main(void)
{
   system("clear"); // CUIDADO
	
   char * pt_entrada;
   pt_entrada  =  le_uma_entrada ( );
   printf("\n Feita uma leitura ===> %s \n" , pt_entrada );
   imprime_entrada ( pt_entrada ); 
   return 1;
  }

char * le_uma_entrada ( void )
{   
	char vetor[]= "aXXXz"; // QUALQUER COISA AQUI.";
	char *pt_vetor;
	int tam_vetor = (int)sizeof(vetor);
	// aqui um scanf ou gets
	printf("\n QTIDADE DE OBJETOS: %d", tam_vetor );
	pt_vetor = &vetor[0];
	//printf("\n %s \n" , vetor); // OK
	//printf("\n %s \n" , pt_vetor); // OK
	return(pt_vetor) ;
}

void imprime_entrada ( char * pt_vetor )
{		
	printf("\n VIA REF ==> %s \n" , pt_vetor);
	//printf("\n TAMANHO DO PT : %d", (int)sizeof(pt_vetor) ); 
	for( ; *pt_vetor != '\0' ; pt_vetor ++ )
    printf("%c " , *pt_vetor);

	return;
}
/************************************************/