#include <stdio.h>
#include <string.h>

int main()
{
char def[41], com[41];
int i, c=0, z;

printf(" insira a string: \n");
scanf("%s", def);
printf(" insira a string a ser comparada: \n");
scanf("%s", com);


printf("%s %s", def, com);
int tam1 = (int) sizeof(def)/ sizeof(def[0]);
int tam2 = (int) sizeof(com)/ sizeof(com[0]);
for(i=0; i<tam2-1; ++i)
{
	for(z=0;z<tam1-1;++z)
	{
		if(  (com[i] == def[z]) && (com[i++] == def[z++])  && (com[++i] != '\0' || def[++z]  != '\0') )
		{
			++c;
		}
	}
}
printf("A string esta contida [%d] vezes na outra", c/5);
return 0;
}

