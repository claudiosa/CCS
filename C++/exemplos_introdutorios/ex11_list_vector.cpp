#include <iostream>
#include <vector>
#include <list>

/*
 *	Vector é baseado em array.
 * 	- Podem mudar dinamicamente;
 *	- Inserção no fim é eficiente. Mas e inserir no meio e no fim?!
 * 	- Posições contíguas na memória.
 *
 * Dicas:
 *  Quando for necessario inserir no fim e no início
 * usa deque que é mais eficiente.
 *
 *  Quando for necessário inserir e remover no meio
 * usar list, devido a implementação eficiente de
 * inserção e deleção em qualquer lugar na EDA.
 *
 *  Vector é extremamente eficiente com acesso aleatório.
 *
 *  Vector fornece acesso indexado rápido com o operador []
 * devido a a alocação em área contígua.
 *
 *
 * - begin 
 * - end
 * - rbegin C++11
 * - rend C++11
 * - size
 * - resize
 * - empty
 * - shrink_to_fit C++11
 * - Access []
 * - at
 * - front
 * - back
 * - push_back
 * - pop_back
 * - insert
 * - erase
 * - clear
 *
 * list (adicionais):
 * - push_front
 * - pop_front
 * */

using namespace std;

int main(void){

	vector<int> my_vector (3, 10);
	cout << "Tamanho do vetor: " << my_vector.size() << endl;
	
	//declarando um iterator para vector do tipo int;
	vector<int>::iterator it;
	it = my_vector.begin();
	//insere um elemento na primeira posição;
	it = my_vector.insert( it, 200);

	cout << "Tamanho do vetor: " << my_vector.size() << endl;
	for( it = my_vector.begin(); it < my_vector.end(); it++)
		cout << ' ' << *it;
	cout << endl;

	for(vector<int>::reverse_iterator it2 = my_vector.rbegin(); it2 < my_vector.rend(); it2++)
		cout << ' ' << *it2;
	cout << endl;

	for(int i = 0; i < (int) my_vector.size(); i++){
		cout << ' ' << my_vector[i] ;
	}
	cout << endl;

	for(int i = 0; i < (int) my_vector.size(); i++){
		cout << ' ' << my_vector.at(i) ;
	}
	cout << endl;

	cout << "Primeiro elemento: " << my_vector.front() << endl;
	cout << "Ultimo elemento: " << my_vector.back() << endl;

	cout << "Inserindo novo elemento 1000 no final" << endl;

	my_vector.push_back(1000);

	for( it = my_vector.begin(); it < my_vector.end(); it++)
		cout << ' ' << *it;
	cout << endl;

	cout << "Tirando último elemento" << endl;
	my_vector.pop_back();

	for( it = my_vector.begin(); it < my_vector.end(); it++)
		cout << ' ' << *it;
	cout << endl;

	cout << "Usando insert para inserir onde eu quiser | quantos elementos eu quiser..." << endl;

	vector<int> teste;
	teste.push_back(1);
	teste.push_back(2);
	teste.push_back(3);
	//insere na terceira posição os três elementos que estão em teste.
	my_vector.insert(my_vector.begin() + 2, teste.begin(), teste.end());

	for( it = my_vector.begin(); it < my_vector.end(); it++)
		cout << ' ' << *it;
	cout << endl;

	cout << "Erase permite apagar um elemento, ou varios..." << endl;
	my_vector.erase(my_vector.begin() + 2);
	
	cout << "Depois:" << endl;
	for( it = my_vector.begin(); it < my_vector.end(); it++)
		cout << ' ' << *it;
	cout << endl;

	my_vector.erase(my_vector.begin() + 4, my_vector.end());

	for( it = my_vector.begin(); it < my_vector.end(); it++)
		cout << ' ' << *it;
	cout << endl;

	cout << "Podemos limpar o vector inteiro usando clear" << endl;
	my_vector.clear();
	if( my_vector.empty()) cout << "Vector vazio" << endl;

	cout << "List possuí uma (eu diria única) diferença:\nPode inserir direto no inicio e eliminar direto do inicio usando push_front e pop_front, nada que um erase não resolva em vector..." << endl;

	list<int> mylist;
	list<int>::iterator itl;
	mylist.push_front(1);//insere no inicio
	mylist.push_front(2);
	mylist.push_front(3);
	mylist.push_front(4);
	mylist.push_front(5);
	cout << "Diferença fundamental, iterator de list nao pode comparar com < end()" << endl;
	for( itl = mylist.begin(); itl != mylist.end(); itl++)
		cout << ' ' << *itl;
	cout << endl;
	while(not mylist.empty()){
		cout << mylist.front() << endl;
		mylist.pop_front();
	}

	cout << "Com as duas estruturas podemos facilmente simular uma pilha!!!" << endl;
	return 0;
}

