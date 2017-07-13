/* Fig. 7.21: fig07_21.c
   Copying a string using array notation and pointer notation. */
#include <stdio.h>

void copy1( char *s1, const char *s2 ); /* prototype */
void copy2( char *s1, const char *s2 ); /* prototype */

int main( void )
{
   char string1[ 10 ]; /* create array string1 */
   char *string2 = "Hello"; /* create a pointer to a string */
   char string3[ 10 ]; /* create array string3 */
   char string4[] = "Good Bye"; /* create a pointer to a string */

   copy1( string1, string2 );
   printf( "string1 = %s\n", string1 );

   copy2( string3, string4 );
   printf( "string3 = %s\n", string3 );	
   return 0; /* indicates successful termination */
} /* end main */

/* copy s2 to s1 using array notation */
void copy1( char *s1, const char *s2 )
{
   int i; /* counter */

   /* loop through strings */
   for ( i = 0; ( s1[ i ] = s2[ i ] ) != '\0'; i++ ) {
      ; /* do nothing in body */
   } /* end for */
} /* end function copy1 */

/* copy s2 to s1 using pointer notation */
void copy2( char *s1, const char *s2 )
{
   /* loop through strings */
   for ( ; ( *s1 = *s2 ) != '\0'; s1++, s2++ ) {
      ; /* do nothing in body */
   } /* end for */
} /* end function copy2 */

int MY_copy(const char *s1, char *s2 )
{
   /* loop through strings */
   for ( ; ( *s2 = *s1 ) != '\0'; s1++, s2++ ) {
      ;
    return 1;   /* do nothing in body */
   }
    return 0; /* end for */
} /* end function copy2 */

