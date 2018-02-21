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
#include <cmath>
#include <iostream>
#include <iomanip>

using namespace std;

int main(){
	double pi = 3.1415926535;
	cout <<  setprecision(10) <<  setiosflags(ios::fixed | ios::showpoint);
	cout << "ceil (Pi): " << ceil(pi) << endl; //maior inteiro
	cout << endl;
	cout << "cos (0): " << cos(0) << endl;
	cout << endl;
	cout << "exp (1) [e^x -> 2.71]: " << exp(1) << endl;
	cout << endl;
	cout << "fabs( -Pi ): " << fabs(-pi) << endl;
	cout << endl;
	cout << "floor( Pi ): " << floor(pi) << endl; //menor inteiro
	cout << endl;
	cout << "fmod( 13.65, 2.33 ):" << fmod(13.657, 2.333) << endl;
	cout << endl;
	cout << "log(e):" << log(2.71) << endl;
	cout << endl;
	cout << "log10(10):" << log10(10) << endl;
	cout << endl;
	cout << "pow(x, y) [x^y]: " << pow(2, 4) << endl;
	cout << endl;
	cout << "sin (0):" << sin(0) << endl;
	cout << endl;
	cout << "sqrt(900):" << sqrt(900) << endl;
	cout << endl;
	cout << "tan(x):" << tan(0) << endl;
	return 0;
}