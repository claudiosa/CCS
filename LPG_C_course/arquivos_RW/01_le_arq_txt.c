/*
char str[999];
FILE * file;
file = fopen( "test.txt" , "r");
if (file) {
    while (fscanf(file, "%s", str)!=EOF)
        printf("%s",str);
    fclose(file);

*/
#include <stdio.h>   /* required for file operations */



int main(void)

{
int c;
FILE *pt_file; /*ESPECIAL: declare the file pointer */
pt_file = fopen("teste.txt", "r");
if (pt_file != NULL) 
  {
    while ((c = getc(pt_file)) != EOF)
        putchar(c);
    fclose(pt_file);
  }


printf("\n \n FIM DE LEITURA \n ");
return 1;
}