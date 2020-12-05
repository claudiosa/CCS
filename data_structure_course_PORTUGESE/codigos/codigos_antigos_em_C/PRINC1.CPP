#include <stdio.h>


/*	void conta_freq ( char x[] , char y, int & , int &);
  */
	void main(void)

	{
		char frase[]= " Isso eh um teste He He He He ";
		int tam, freq_x;
		char x = 'e';
                printf("\n %s ", frase);
    /*
		conta_freq ( &frase[0] , x , freq_x, tam );
		/* nao vai o & comercial na frente de freq_x e tam */
                */
                /*
	        printf("\n Freq. de caracteres eh: %d || %x ", freq_x, &freq_x );
		printf("\n Tamanho eh: %d || %x ", tam, &tam );
                */
		getchar();

	}


/*
	void conta_freq ( char x[] , char l, int &n , int & i)
	{
		n = 0;
		for (i = 0; x[i] != '\0' ; i++)

			if (x[i] == l)
				n++;

		return;
	}
*/
