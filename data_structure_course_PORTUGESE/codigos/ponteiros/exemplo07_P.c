#include <stdlib.h>
#include <stdio.h>

// funcoes a serem apontada via ponteiros
float  f_div(int a,  int b);
int    f_dist(char a,  char b);

int main(void)
{  	
     char a = 'a' , z = 'z';
     int  x = 3 , y = 4 ;
     // cria ponteiros para funcoes ... veja tipagem
     float (* pt_divisao) (int, int); 
     int   (* pt_distancia) (char, char) ; 
     /* inicializa ponteiros as funcoes */
     pt_divisao = f_div ;  
     pt_distancia = f_dist; /* inicializa ponteiro */

     // chamando as funcoes funcao ... retornando algo
     float R_1 = (*pt_divisao) (x, y);   /* invoca funcao */
     int R_2 = (*pt_distancia) (a, z);  /* invoca funcao */

     system("clear"); // OK ... mas cuidar
     
    printf("SAIDAS: %6.2f : %d", R_1 , R_2 );
    printf("\nENDERECOS: %x = %x ", pt_divisao, f_div ); 
    printf("\nENDERECOS: %x : %x ", &pt_divisao, &f_div ); 
    printf("\nENDERECOS: %x = %x ", pt_distancia, f_dist ); 
    printf("\nENDERECOS: %x : %x ", &pt_distancia, &f_dist ); 
    printf("\n ... Acabou ....\n");
   return 1;
}
// AS FUNCOES
float f_div(int a,  int b)
 { //printf("\n %d .. %d \n", a , b);
   float resp = ((float)a) / b; 
   return ( resp );
 }

int f_dist(char a,  char b)
 { 
   return (b - a);
  }
