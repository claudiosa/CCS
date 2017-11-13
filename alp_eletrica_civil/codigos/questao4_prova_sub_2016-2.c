/*
   Enunciado da questao #4 da prova substitutiva:

   Fa�a um programa em C que determine quanto tempo transcorreu entre duas marca��es de tempo.
   Sao dados como entrada:
   - tempo1 = HH:MM:SS e
   - tempo2 = hh:mm:ss

   Exemplo: entre as marca��es tempo1 = 10:05:47 e tempo2 = 21:00:01 transcorreram 10:54:14
*/
#include <stdio.h>

int main()
{
    int HH, MM, SS,                // tempo 1
        hh, mm, ss,                // tempo 2
        horas, minutos, segundos;  // tempo transcorrido

    printf("Digite o tempo inicial: ");
    scanf("%d %d %d", &HH, &MM, &SS);

    printf("\nDigite o tempo final: ");
    scanf("%d %d %d", &hh, &mm, &ss);

    // Descri��o da solu��o
    // Passo #1 = converter o tempo 1 e tempo 2 para segundos transcorridos
    // Passo #2 = determinar a diferen�a (em segundos)
    // Passo #3 = converter o valor resultante de volta para horas, minutos e segundos

    int SegundosTotais_1 = HH * 3600 + MM * 60 + SS;  // 1 hora = 3600 segundos, 1 minuto = 60 segundos

    if(hh < HH) // verifica��o se o horario final n�o pertence ao dia seguinte
        hh += 24;

    int SegundosTotais_2 = hh * 3600 + mm * 60 + ss;  // idem anterior

    int DifTempo = SegundosTotais_2 - SegundosTotais_1;

    // convertendo o resultado para h:m:s novamente
    horas = DifTempo / 3600;
    DifTempo -= horas * 3600;

    minutos = DifTempo / 60;
    DifTempo -= minutos * 60;

    segundos = DifTempo;

    printf("\n\nTempo transcorrido: %d horas %d minutos e %d segundos", horas, minutos, segundos);

    return 1;
}
