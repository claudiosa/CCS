#include <stdio.h>
#include <string.h>

int main()
{
char str1[] = "abfbaasdfaafdgdsaaaa";
//char str1[] = "aaoaoo";
char str2[] = "aa";

int tam1 = (int) sizeof(str1)/ sizeof(str1[0]);
int tam2 = (int) sizeof(str2)/ sizeof(str2[0]);
int cont=0;
bool chave = false;
printf("LEITURA OK %s:%d || %s:%d", str1, tam1, str2, tam2);

for(int i=0; i < (tam1-1) ; ++i)
{
	if( str1[i] != str2 [ 0 ] )
	{
		chave = false;
	} // vai para o final ... e avanca no vetor principal	
	else
	{ 
	  for(int j=0 ; str2[j] != '\0' ; ++j)
	  // for(int j=0 ; j < (tam2-1) ; ++j)
	  {
		if(  str1[i + j] == str2[j]  )
		{ 
			chave = true;
		}
		else
		{
		  chave = false;
		  break;
		}		
	  } //fim do for
	  
	  if(chave) // conta se toda string estava dentro da outra
	   {cont++;}
	 }// fim do if MAIOR
 }	  // for externo
	 
   printf("\n\nA string => %s <=  estah contida  %d  vezes\n em => %s <=\n", str2, cont, str1);

return 0;
}

