
#include <stdio.h>
#include <math.h>

int main()
  {
	int a, b, c;
	float raiz_01, raiz_02;
	printf("\n POR GENTILEZA ...os 3 coeficientes:");
    scanf("%d %d %d",   &a, &b, &c);
    // printf("\nTESTANDO: %d %d %d", a, b, c);
	float DELTA;
	DELTA = pow(b,2) - 4*a*c; // pow(b,2) = b*b
	printf("\n DELTA: %0.4f" , DELTA);
	// 4 casas apos a virgula
	if(DELTA >= 0)
	{   
	  raiz_01 = ((-1)*b + sqrt(DELTA))/(2*a);
	  raiz_02 = ((-1)*b - sqrt(DELTA))/(2*a);
	  printf("\n RAIZ_01: %0.4f" , raiz_01);
	  printf("\n RAIZ_02: %0.4f" , raiz_02);
	 }
	 else
	 {
	  printf("\n RAIZES DO ALÉM = IMAGINÁRIAS");
     } 
		
 printf("\n \n Profs. are humans !!!! \n\n");
 return(1);
}
