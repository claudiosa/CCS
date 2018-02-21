/* */ 
#include <stdio.h> 
#define SIZE 41 // tamanho das populacao 
 
/*  
   function prototypes  
 
*/ 
 
void print_Array( const char a[] ); 
//void inicializa_Array( const char array[] ); 
void inicializa_Array( char *a ); 
void str_copy( char *origem , char *destino ); 
int str_compare( char *origem , char *destino ); 
void evolui_Array( char *pt_array ); 
void substring_3(char *pt,  char sub_3[]); 
 
 
/* function main begins program execution */ 
int main( void ) 
{ 
   char P_new[SIZE]; 

/* 
Chamar #2 em A1 e A2 
Laço por n geracoes 
	Chamar  #5 (Array_new A_2) 
	Chamar #4 Copiar  Array_new -> A_2 
        Chamar #3 
fim_do_Laço 
*/	 
   int n , Geracoes =  5; // ler do teclado 
   inicializa_Array( P_new );	 
   print_Array( P_new ); 
 
 
   // TESTANDO AS FUNCOES CRIADAS
   /*
   char P_temp[SIZE]; 
   str_copy( P_new , P_temp ); 
   print_Array( P_temp ); 

   if(   str_compare( P_new , P_temp ) == 1)
   printf("\n IGUAIS");
   else
   printf("\n Diferentes");
   P_temp[30] = 'a';
   if(   str_compare( P_new , P_temp ) == 1)
   printf("\n IGUAIS");
   else
   printf("\n Diferentes");
   */
   
 
for(n=0; n < Geracoes; n++) 
  { 
	  // Evolui FUNCAO 
	  //evolui_Array(&P_new[0]);
	  evolui_Array(P_new);  
	  print_Array( P_new ); 
  } 
	 
 
   return 0; /* indicates successful termination */ 
} /* end main */ 
/******************************************************/ 
 
/* calculate average of all response values */ 
void inicializa_Array( char *pt_array ) 
{ 
   int j; /* counter for totaling array elements */ 
    
   /* preenchendo de - o array >>> rever */ 
   for ( j = 0; j < (SIZE-1); j++ ) { 
      *(pt_array + j)  = '-'; 
   }  
   
   *(pt_array + (SIZE-1) ) = '\0'; // ULTIMA posicao 
   *(pt_array + (SIZE/2) ) = '#'; 
    
    
} /* end function mean */ 
 

void substring_3(char *pt, char sub_3[]) 
{ 
   
  sub_3[0] = *(pt-1); 
  sub_3[1] = *(pt); 
  sub_3[2] = *(pt+1); 
  sub_3[3] = '\0'; // garantias 
  return; 
}   
 
/**************************************************************/ 
 
/* output array contents (20 values per row) */ 
void print_Array( const char a[] ) 
{ 
   int j; /* counter */ 
 
   /* output array contents */ 
   for ( j = 0; a[ j ] != '\0' ; j++ )  
   { 
      printf( "%c", a[ j ] ); 
   }
   printf( "\n");
    /* end for */ 
   //printf( "\n %d caracteres impresso! -- comente depois " , j); 
} /* end function printArray */ 
 
 
/**************************************************************/ 
  int str_size ( char *x ) 
        { 
                int i; 
                for (i = 0; *(x+i) != '\0' ; i++) 
		;
		//printf("\n tamanho eh: %d", i);
                return(i); 
        } 
 
 /**************************************************************/ 
/**************************************************************/ 
  int str_compare ( char *pt_str1,  char *pt_str2  ) 
        { 
                while((*pt_str1 != '\0') && (*pt_str2 != '\0')) 
                { 
                if(*pt_str1 != *pt_str2) 
                return (0); // diferentes conteudos
                pt_str1++; 
                pt_str2++; 
                }  
                 
                if(*pt_str1 != *pt_str2) 
                return (0); // tamanhos diferentes 
                else 
                return(1); 
        } 
  
 /**************************************************************/ 
/**************************************************************/ 
 // ORIGEM DESTINO  
 void str_copy ( char *pt_str1,  char *pt_str2  ) 
        { 
          while(*pt_str1 != '\0') 
             { 
              *pt_str2 = *pt_str1;             	      
                pt_str1++; 
                pt_str2++; 
                } 
           *pt_str2 = *pt_str1; // faltou o \0            	      	
            return;     
        } 
  
/**************************************************************/ 
void evolui_Array(char *pt) 
{ 
   char sub_3[4] = "    "; 
   printf("\n sub3 %s", sub_3); 
   char *ancora; 
   ancora = pt;// onde estah o inicio do array 

   print_Array( pt );    
    
   int tamanho = str_size(pt); 
   // printf("\n tamanho %d", tamanho); 
   // cria string temporaria ou AUX 
   char str_temp [tamanho]; 
   // ou use o DEFINE 
    
   str_temp [0] = *pt; 
   pt++; // esta na posicao 1 do array 
   // contagem 0 ate tamanho-1 ... 
   //
  int i;  
 for( i = 1 ; i < (tamanho-1) ; i++ ) 
  { 
       substring_3(pt, sub_3);// CUIDAR AQUI 
       print("SUB 3:   %s", sub_3);
 
	 // compara a sub_3 com a REGRA 30 por exemplo 
	if (  str_compare(sub_3, "###") ==1 ) 
	{ 
	 str_temp[i] = '-';// ver regra 30 
        } 
	else if (str_compare(sub_3, "##-")==1) 
	{ 
	 str_temp[i] = '-';// ver regra 30 
        } 
	else if (str_compare(sub_3, "#-#")==1) 
	{ 
	 str_temp[i] = '-';// ver regra 30 
        } 
	else if (str_compare(sub_3, "##-")==1) 
	{ 
	 str_temp[i] = '#'; // ver regra 30 
        } 
	else if (str_compare(sub_3, "-##")==1) 
	{ 
	 str_temp[i] = '#'; // ver regra 30 
        } 
	else if (str_compare(sub_3, "#-#")==1) 
	{ 
	 str_temp[i] = '#'; // ver regra 30 
        } 
	else if (str_compare(sub_3, "--#")==1) 
	{ 
	 str_temp[i] = '-';// ver regra 30 
        } 
	else  { 
         str_temp[i] = '-'; // ver regra 30 
       } 
        
   pt++; // next
   } // FIM DO FOR
/*
Initial (t)	 111	110	101	100	011	010	001	000
Valeur seg (t+1)  0	 0	 0	 1	 1	 1	 1	 0
*/
 
// por garantias aqui 
      //str_temp [0] =  *ancora; 
      str_temp [tamanho-1] =  '\0'; 
//      pt = ancora;
       // ou ancora = pt-tamanho; 
      str_copy ( &str_temp[0] , ancora ); 
      print_Array( str_temp );    
//return; // ao final de uma passada 
} 

/**************************************************************/ 
