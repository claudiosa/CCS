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

int main(){
	int total, num_notas, nota;
	total = num_notas = nota = 0;
	double media;

	cout << "Insira uma nota (-1 para sair):" << endl;
	cin >> nota;

	while( nota != -1){
		total = total + nota;
		num_notas++;
		cout << "Insira uma nota (-1 para sair):" << endl;
		cin >> nota;
	}

	if (num_notas != 0){
		media = static_cast< double >(total) / num_notas;//cria uma cópia temporária do tipo double
		cout << "A média da turma é: " << setprecision(2) << setiosflags(ios::fixed | ios::showpoint) << media << endl;
	}

	cout << setw(35) << "Legal né?! e.e" << endl;
	return 0;

}