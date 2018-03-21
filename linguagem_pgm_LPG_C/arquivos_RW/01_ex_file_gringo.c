/* Fig. 11.3: fig11_03.c
   Create a sequential file */
#include <stdio.h>

int main( void )
{ 
   int account; /* account number */
   char name[ 30 ]; /* account name */
   double balance; /* account balance */

   FILE *cfPtr; /* cfPtr = clients.dat file pointer */

   /* fopen opens file. Exit program if unable to create file  */
   if ( ( cfPtr = fopen( "clients.dat", "w" ) ) == NULL ) {
      printf( "File could not be opened\n" );
   } /* end if */
   else { 
      printf( "Enter the account, name, and balance.\n" );
      printf( "Enter EOF to end input.\n" );
      printf( "? " );
      scanf( "%d%s%lf", &account, name, &balance );

      /* write account, name and balance into file with fprintf */
      while ( !feof( stdin ) ) { 
         fprintf( cfPtr, "%d %s %.2f\n", account, name, balance );
         printf( "? " );
         scanf( "%d%s%lf", &account, name, &balance );
      } /* end while */
      
      fclose( cfPtr ); /* fclose closes file */
   } /* end else */

   return 0; /* indicates successful termination */
} /* end main */

