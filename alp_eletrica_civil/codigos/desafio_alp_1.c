#include <stdio.h>

int main()
{
    int tamanho, v=0, i, menor=0, maior=0, z, c=0;

    printf("Digite o tamanho do vetor:\n");
    scanf("%i", &tamanho);
    //printf("%i\n", tamanho);

    int vetor[tamanho];

    for(i=0; i<tamanho; ++i)
    {
        //printf("%i", i);
        ++v;
        printf("Digite o %i vetor:\n", v);
        scanf("%i", &vetor[i]);
    }

    menor = vetor[0];
    maior = menor;

    printf("\n{ ");

    for(i=0; i<tamanho; ++i)
    {
        for(z=0; z<tamanho; ++z)
        {
            if(vetor[z]<menor)
            {
                menor = vetor[z];
                c = z;
            }

            if(vetor[z]>maior)
            {
                maior = vetor[z];
            }
        }

        /*for(z=0; z<tamanho; ++z) {
        printf("vetor[%i] = %i\n", z, vetor[z]); }
        printf("%i \n", maior);
        printf("%i ", c);
        printf("\n\n");*/

        printf("%i ", menor);

        menor = maior;
        vetor[c] = maior;
    }

    printf("}");

    return 0;
}
