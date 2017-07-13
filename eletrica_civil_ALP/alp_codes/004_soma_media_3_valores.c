#include <stdio.h>
int main()
	{   // INICIO { ... comentado
	 float N1, N2, N3, soma, media;
	 /*
	 printf(" \n DIGITE N1: "); 
	 scanf("%f", & N1);
	 printf(" \n DIGITE N2: "); 
	 scanf("%f", & N2);
	 printf(" \n DIGITE N3: "); 
	 scanf("%f", & N3);
	 */
	 
	  scanf(" %f %f %f",  & N1 ,  & N2, & N3);
	 
	 
	 // Calculo
	 soma = N1 + N2 + N3; // ATRIBUICAO ... dif da MAT
	 media = soma / 3;
	 printf(" SAIDAs: \n");  // print + f = imprima no arquivo = te
	 printf("\n NUMs: %6.3f %6.3f %6.3f", N1, N2, N3 );
	 printf("\n SOMA: %6.3f MEDIA: %6.3f", soma, media );
	  
	 printf("\n \t Profs are humans !!!! \n\n");
 return(1);
} // fim do algoritmo
