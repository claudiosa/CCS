#include <stdio.h>
#include <string.h>
//#include <iostream>
//using namespace std;

int main()
{
   char frase_1[40];
   //char frase_2[100];
  
 // INICIALIZA STRING 
    int m = (int) sizeof(frase_1)/sizeof(frase_1[0]);
    //memset(dest, '\0', sizeof(dest)); // inicializa dest
   
    for(int j=1; j < m ; j++) // 
    { frase_1[j] = '\0';
    }	
   
   // LENDO ALGO
    printf ("1 => uma frase please: " );
    fgets(frase_1, m, stdin); 
    //scanf with %s accepts only String which does not contain whitespaces (blanks/space)
    //fgets(frase_1, m, stdin);
    printf("Final %d : %s\n", m, frase_1);
   
   
   // OU
   
    printf ("\n2 => uma frase please: " );
    //gets(frase_1);
    // getline(frase_1, m, stdin);
   
   scanf("%[^\n]s", frase_1);
    printf("Final %d : %s\n", m, frase_1);
    
    // IMPRIMINDO VIA CHAR
    for(int j=1; j < m ; j++) // 
    { 
	 printf(" : %c" , frase_1[j]);
     }	  
   return(0);
}
