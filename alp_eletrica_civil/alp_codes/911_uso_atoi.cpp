#include <stdio.h>


#include <stdlib.h>
#include <string.h>

 void itoa(int n, char s[]);
 void reverse(char s[]);
int main()
{
   int val;
   char str[20];
   char str2[20];
   
   strcpy(str, "98993489");
   val = atoi(str);
   printf("String value = %s, Int value = %d\n", str, val);

   itoa (val,str2);
   printf("String 2 value = %s, Int value = %d\n", str2, val);

   strcpy(str, "tutorialspoint.com28");
   val = atoi(str);
   printf("String value = %s, Int value = %d\n", str, val);

   

   return(0);
}



/* itoa:  convert n to characters in s */
 void itoa(int n, char s[])
 {
     int i, sign;

     if ((sign = n) < 0)  /* record sign */
         n = -n;          /* make n positive */
     i = 0;
     do {       /* generate digits in reverse order */
         s[i++] = n % 10 + '0';   /* get next digit */
     } while ((n /= 10) > 0);     /* delete it */
     if (sign < 0)
         s[i++] = '-';
     s[i] = '\0';
     reverse(s);
}


/* reverse:  reverse string s in place */
 void reverse(char s[])
 {
     int i, j;
     char c;

     for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
         c = s[i];
         s[i] = s[j];
         s[j] = c;
     }
}  
