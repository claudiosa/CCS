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

int main(){
	int a, b, soma;
	std::cout << "Digite o primeiro inteiro: " << std::endl;
	std::cin >> a;
	std::cout << "Digite o segundo inteiro:" << std::endl;
	std::cin >> b;
	soma = a + b;
	std::cout << "A soma é: " << soma << std::endl;
	return 0;
}