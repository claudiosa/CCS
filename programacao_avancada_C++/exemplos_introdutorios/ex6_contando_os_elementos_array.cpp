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
	int n[10] = {19, 13, 3, 7, 9, 5, 4, 8, 10, 1};
	
	cout << "Elemento" << setw(13) << "Valor" << setw(17) << "Histograma" << endl;
	
	for(int i = 0; i < 10; i++){
		cout << setw(7) << i << setw(13) << n[i] << setw(9);
		
		for(int j = 0; j < n[i]; j++)
			cout << '*';
		
		cout << endl;
	}
	return 0;
}

