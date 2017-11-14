#include <stdio.h>
#include <string.h>

/* An ordinary function declaration, for reference */

char *strcpy_like(char *dst, const char *src); 

/* The following declares "strcpy_funcptr". */

typedef char *(*strcpy_funcptr)(char *, const char *);

/* Declare a function which returns a pointer to a function. */

strcpy_funcptr get_strcpy_ptr (void);

/* This function takes a pointer to a function as an argument. */

void do_strcpy (strcpy_funcptr some_strcpy, char * dst, const char * src)
{
    /* Here is where we finally call the function. */
 
    (*some_strcpy) (dst, src);
}

#define str_length 18

int main ()
{
    char src[str_length] = "This is a string.";
    char dst[str_length];

    /* This declares "strcpy_ptr" using the above typedef. */

    strcpy_funcptr strcpy_ptr;

    /* Set the value of "strcpy_ptr" using "get_strcpy_ptr". */

    strcpy_ptr = get_strcpy_ptr ();

    /* Pass the pointer to "do_strcpy". */

    do_strcpy (strcpy_ptr, dst, src);

    printf ("dst = %s\n", dst);
}

strcpy_funcptr get_strcpy_ptr (void)
{
    return & strcpy_like;
}

char * strcpy_like(char * dst, const char * src)
{
    return strcpy (dst, src);
}
