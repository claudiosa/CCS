/* */
#include <stdio.h>
#define SIZE 41 // tamanho das populacao

/* 
   function prototypes 

*/

void print_Array( const char a[] );
//void inicializa_Array( const char array[] );
void inicializa_Array( char *a );
void copia_Array( char *origem , char *destino );
void evolui_Array( char *novo , char *temp );



/* function main begins program execution */
int main( void )
{
   char P_new[SIZE];
   char P_temp[SIZE];
	
   inicializa_Array( P_new );	
   print_Array( P_new );
	
	
	
   return 0; /* indicates successful termination */
} /* end main */

/* calculate average of all response values */
void inicializa_Array( char *pt_array )
{
   int j; /* counter for totaling array elements */
   
   /* preenchendo de - o array */
   for ( j = 0; j < (SIZE-1); j++ ) {
      *(pt_array + j)  = '-';
   } 
  
   *(pt_array + (SIZE-1) ) = '\0';
   *(pt_array + (SIZE/2) ) = '#';
   
   
} /* end function mean */


//void inicializa_Array( const char array[] )
//{
//   int j; /* counter for totaling array elements */
//   for ( j = 0; j < (SIZE-1); j++ ) {
 //     array[ j ] = '-';
  // } 
  
  // array[ (SIZE-1) ] = '\0';
  
//}



/* output array contents (20 values per row) */
void print_Array( const char a[] )
{
   int j; /* counter */

   /* output array contents */
   for ( j = 0; a[ j ] != '\0' ; j++ ) 
   {
      printf( "%c", a[ j ] );
   } /* end for */
   printf( "\n %d caracteres impresso! -- comente depois " , j);
} /* end function printArray */


/**************************************************************/

  int size_str ( char x[] )
        {
                int i;
                for (i = 0; x[i] != '\0' ; i++)
                return(i);
        }

