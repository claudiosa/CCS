#include <stdlib.h>
#include <stdio.h>

int strtam(char   *  );

int main(void)
{   char vetor[] = "ABCDEFG" ;
   //  char *lista = "Ola como vai?"; ... HUM ...
   char *pt;
   pt = vetor; //mais saudavel => pt = &vetor[0];

   system("clear");
   printf("O tamanho de \"%s\" e %d caracteres.\n", vetor, strtam( pt ));
   printf("\n ... Acabou ....");
   return 1;
}

int strtam(char *s){
    int tam=0;
    //while(*(s + tam++) != '\0');
    while(*s != '\0')
    {   tam++;
		s++;
	}
    return  tam; //tam-1; --> \0
}
