#include <stdio.h>
#include <string.h>

/* An ordinary function declaration, for reference */

char *strcpy_like(char *dst, const char *src); 

/* Pointer to strcpy-like function */

char *(*strcpy_ptr)(char *dst, const char *src);

#define str_length 18

int main ()
{
    char src[str_length] = "This is a string.";
    char dst[str_length];

    /* Set the value of "strcpy_ptr" to be "strcpy". */
    strcpy_ptr =  strcpy_like;
    /* This works too */
    strcpy_ptr = & strcpy_like;
 
    (*strcpy_ptr) (dst, src);
    printf ("dst = %s\n", dst);
}

char * strcpy_like(char * dst, const char * src)
{
    return strcpy (dst, src);
}
