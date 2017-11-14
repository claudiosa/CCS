#include <string.h>
#include <stdio.h>

int palindrome (const char * s)
{
    int length;
    int j;
    int mid;

    length = strlen (s);
    mid = length / 2;
    for (j = 0; j < mid; j++) {
        char left = s[j];
        char right = s[length - j - 1];

        if (left != right) {
            return 0;
        }
    }
    return 1;
}

int main (int argc, char ** argv)
{
    int i;
    for (i = 1; i < argc; i++) {
        printf ("%s is ", argv[i]);
        if (! palindrome (argv[i])) {
            printf ("not ");
        }
        printf ("a palindrome.\n");
    }
    return 0;
}
