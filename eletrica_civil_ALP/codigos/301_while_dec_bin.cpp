/*
RELEMBRANDO ...
Suppose input decimal number is 13
Step 1. 13/2 , Remainder = 1, Quotient = 6
Step 2. 6/2 , Remainder = 0, Quotient = 3
Step 3. 3/2 , Remainder = 1, Quotient = 1
Step 4. 1/2 , Remainder = 1, Quotient = 0
Now, the Binary equivalent of 13 is the remainders in reverse order : 1101
 */ 

#include <stdio.h>
int main() {
    int n , resto;
    
	long int binario = 0;
	int i = 1;
  
    printf("Entre com um NUM decimal: ");
    scanf("%d", &n); // n eh o decimal
    
    
    while(n != 0) {
        resto = n % 2; // RESTO da divisao 
        n = n / 2; // toma o quociente inteiro
        printf("\n Valor n: %d || Resto = %d || Quociente = %d ", 
                ((n*2) + resto), resto, n );
        // armazenar o binario como se fosse um decimal
        // Ex: 101 ... teve que ir a casa da CENTENA
        // uma sacada LEGAL ... faca  no PAPEL ISTO ...
        binario = binario + (resto*i);
        i = i * 10;
    }  
    
    printf("\n\n ==> O binario de %d EH %ld", n ,  binario);
     
}
