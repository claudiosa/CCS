#include <stdio.h>

int main ()
{
    const char * test = "This is a fox.";
    printf ("No qualification: '%s'\n", test);
    printf ("Only first four bytes: '%.*s'\n", 4, test);
    printf ("Get some middle bytes: '%.*s'\n", 3, test + 10);
    return 0;
}
