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

int main(int argc, char **argv){
	int *n = new int[10];
	// Ou..int n[10];
	
	for(int i = 0; i < 10; i++)
		n[i] = 0;
	
	cout << "Elemento" << setw(13) << "Valor" << endl;
	
	for (int i = 0; i < 10; i++)
		cout << setw(7) << i << setw(13) << n[i] << endl;
	
	int k[10] = {32, 27, 64, 18, 25, 95, 100, 39, 10, 19};
	cout << "Elemento" << setw(13) << "Valor" << endl;
	
	for (int i = 0; i < 10; i++)
		cout << setw(7) << i << setw(13) << k[i] << endl;
	
	return 0;
}

