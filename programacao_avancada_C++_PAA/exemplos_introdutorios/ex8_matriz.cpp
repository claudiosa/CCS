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
#include <cstdlib>

using namespace std;

int main(int argc, char **argv){
	
	int **matrizID = new int*[10];
	for(int i = 0; i < 10; i++){
		matrizID[i] = new int[10];
	}
	//int matrizID[10][10] = {{0}};
	
	for(int i = 0; i < 10; i++){
		for(int j = 0; j < 10; j++){
			if ( i == j ){
				matrizID[i][j] = 1;
			}
		}
	}
	
	int K[10][10] = {{0}};
	srand( time(NULL));
	
	for(int i = 0; i < 10; i++){
		for(int j = 0; j < 10; j++){
				K[i][j] = rand() % 10 + 1;
		}
	}
	
	int soma = 0, res[10][10] = {{0}};
	
	for(int i = 0; i < 10; i++){
		for(int j = 0; j < 10; j++){
			for(int k = 0; k < 10; k++){
				soma += K[i][k]*matrizID[k][j];
			}
			res[i][j] = soma;
			soma = 0;
		}
	}
	
	cout << "K: " << endl;
	for( int i = 0; i < 10; i++ ){
		for( int j = 0; j < 10; j++){
			cout << setw(3) << K[i][j];
		}
		cout << endl;
	}
	
	cout << "I: " << endl;
	for( int i = 0; i < 10; i++ ){
		for( int j = 0; j < 10; j++){
			cout << setw(3) << matrizID[i][j];
		}
		cout << endl;
	}
	
	cout << "R = K x I" << endl;
	cout << "R: " << endl;
	
	for( int i = 0; i < 10; i++ ){
		for( int j = 0; j < 10; j++){
			cout << setw(3) << res[i][j];
		}
		cout << endl;
	} 
	return 0;
}

