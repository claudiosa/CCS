/*
 * Mateus Boiani - mateuz.boiani@gmail.com 		
 * 
 * Agosto / 2016
 *
 * Introdução a C++
 * 
 * Universidade do Estado de Santa Catarina
 *
 * Departamento de Ciência da Computação
*/
 
#include <iostream>
#include <iomanip>

using namespace std;

int buscaBinaria( const int [], int, int, int, int);
void imprimeCabecalho( int );
void imprimeLinha( const int[], int, int, int, int);

int main(int argc, char **argv){
	const int arrayTam = 15;
	int a[ arrayTam ], chave, resultado;
	
	for(int i = 0; i < arrayTam; i++)
		a[ i ] = 2 * i;
	
	cout << "Digite um número entre 0 e 28: ";
	cin >> chave;
	
	imprimeCabecalho( arrayTam );
	resultado = buscaBinaria(a, chave, 0, arrayTam - 1, arrayTam);
	
	if( resultado != -1 )
		cout << chave << " encontrado no elemento array " << resultado << endl;
	else
		cout << chave << " não encontrado." << endl;
	
	return 0;
}

int buscaBinaria( const int b[], int buscaChave, int menor, int maior, int tamanho){
	int meio;
	
	while ( menor <= maior){
		meio = ( menor + maior ) / 2;
		
		imprimeLinha(b, menor, meio, maior, tamanho);
		
		if (buscaChave == b[meio])
			return meio;
		else if(buscaChave < b[meio])
			maior = meio - 1;
		else
			menor = meio + 1;
	}
	
	return -1;
}

void imprimeCabecalho( int tamanho ){
	int i;
	for (i = 1; i <= 4 * tamanho; i++)
		cout << '_';
	
	cout << endl;
			
	for( i = 0; i < tamanho; i++ )
		cout << setw( 3 ) << i << ' ';
	 
	cout << endl;
	
	for (i = 1; i <= 4 * tamanho; i++)
		cout << '-';
	
	cout << endl;
}

void imprimeLinha( const int b[], int menor, int meio, int maior, int tamanho){
	for( int i = 0; i < tamanho; i++ )
		if ( i < menor || i > maior )
			cout << "   ";
		else if (i == meio)
			cout << setw( 3 ) << b[i] << '*';
		else
			cout << setw( 3 ) << b[i] << ' ';
		
	cout << endl;
}
