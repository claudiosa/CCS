#include <stdio.h>
int main() {
	int foo(int );
    int contagemRegressiva(int);
    foo(0);
    contagemRegressiva(5);
    return 0;
}

int foo(int i) 
 {
    if (i < 4) {
        printf("%d\n", i);
        foo(i + 1);
        // UM RETURN NAO ADIANTA EM NADA ...
    }
   return 1; 
  }

int contagemRegressiva(int n)
  {if (n == 0) {
	  printf("\nDecolar!\n");
	}
   else{
     printf("\t%d", n);
     contagemRegressiva(n-1);
	}
	return (1);
}

/*
 *>>> def contagemRegressiva(n):
...   if n == 0:
...     print('Decolar!')
...   else:
...     print(n)
...     contagemRegressiva(n-1)
... 
>>> contagemRegressiva(5)

 */ 
