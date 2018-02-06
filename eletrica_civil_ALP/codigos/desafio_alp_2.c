#include <stdio.h>
// MATHEUS GASPERIN ... 
int main()
{
    int tamanho, v, c=0, i, z, x=0;

    printf("Quantos numeros voce ira inserir:\n");
    scanf("%i", &tamanho);

    int vetor[tamanho], vetor2[tamanho];

    for(i=0, v=1; i<tamanho; ++i, ++v)
    {
        printf("Digite o %i vetor:\n", v);
        scanf("%i", &vetor[i]);
        vetor2[i] = vetor[i];
    }

    for(i=0; i<tamanho; ++i)
    {// quantas vezes um valore estah no outro
       for(z=0; z<tamanho; ++z)
        {
             if(vetor[i] == vetor2[z])            {
             c = c+1;
            }
        }

        for(z=0; z<=i; ++z)
        {
            if(vetor[i] == vetor2[z])
            {
                x = x+1;
            }
        }

        if(x == 1)
        {
            printf("%i : %i\n", vetor[i], c);
        }

        x = 0;
        c = 0;
    }

    return 0;
}
