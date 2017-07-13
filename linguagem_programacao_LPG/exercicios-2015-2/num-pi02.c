#include <stdio.h>
#include <math.h>
//EM MATH TEM ISTO #define M_PI 3.14159265358979323846

int main (void)
{
     float  num_pi = 0; 
     int  sinal, n = 1, num_entradas=0;
     float erro;// = 0.001;
     int casos_testes;
     scanf("%d \n", &casos_testes);
     
     while(num_entradas < casos_testes)
     {
     scanf("%f ", &erro);
     // INICIALIZACOES
     num_pi = 0;
     n = 1;
     while(1)
     {
     sinal = (int)pow((-1),(n-1)); 
     num_pi = num_pi + (float)(sinal*4)/(2*n-1);
    // printf("\n PI parcial: %f ", num_pi );
     
     if( fabs(M_PI - num_pi) < erro)
      {break;
      }	  
      else
      {n++;
      } 	  
     
     }
    
     printf("\n Com %d termos %f \n ", n , num_pi);
     num_entradas++;
    }
    return 0;
}
