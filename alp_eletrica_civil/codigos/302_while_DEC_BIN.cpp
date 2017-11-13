/*
decbin.c
    Este programa converte um numero expresso em base decimal para seu equivalente em base binaria

    Exemplo:
    59/2 = 29 (resto: 1)
    29/2 = 14 (resto: 1)
    14/2 = 7  (resto: 0)
    7/2  = 3  (resto: 1)
    3/2  = 1  (resto: 1)

    Concatenando o ultimo quociente com todos os restos em ordem inversa temos: 59 (dec) = 111011 (bin)

    UNIVERSIDADE DO ESTADO DE SANTA CATARINA (UDESC)
    Rogerio E. da Silva, 2017
*/
#include <stdio.h>
#include <string.h>

int main()
{
    int  numero,         // armazena o numero a ser convertido
         numeroInicial;  // salva o numero inicial para posterior exibiçao no resultado
    char resultado[15],  // armazena o resultado final da conversao
         temp[15];       // variavel temporaria que armazena a conversao de cada digito em binario


    // ------------------------ INTERFACE INICIAL ------------------------------
    printf("OBJETIVO: Conversao decimal -> binario\n\n");

    // ------------------------- ENTRADA DE DADOS ------------------------------
    printf("Digite um numero no sistema decimal: ");
    scanf("%d", &numero);

    // --------------------------- PROCESSAMENTO -------------------------------
    numeroInicial = numero;
    strcpy(resultado, "");

    while(numero > 1)
    {
        if(numero % 2 == 1) // checa o resto da divisao por 2
            strcpy(temp, "1");
        else
            strcpy(temp, "0");
        strcpy(resultado, strcat(temp, resultado)); // resultado = temp + resultado

        numero /= 2;
    }

    // adiciona o ultimo numero ao resultado
    if(numero == 1)
        strcpy(temp, "1");
    else
        strcpy(temp, "0");
    strcpy(resultado, strcat(temp, resultado));

    // ------------------------- SAIDA DE RESULTADOS  ------------------------------
    printf("\nResultado da Conversao: %d (dec) = %s (bin)\n", numeroInicial, resultado);

    return 1; // encerramento do programa
}
