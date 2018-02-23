/*
* Exemplo de uso, instanciamento, como inserir e como remover elementos,
* mostrar priority queue ordenada,
* mostrar que stack saí sempre o topo...
*/
#include <iostream>
#include <stack>

using namespace std;

template< class T >
void popElements( T &s );

int main(int argc, char **argv){
	//cria uma nova stack (pilha)
	stack<int> first_stack;

	if( first_stack.empty() )//verifica se a pilha ta vazia
		cout << "Pilha vazia!" << endl;
	else
		cout << "Tamanho inicial da pilha é: " << first_stack.size() << endl;

	for( int i = 0; i < 10; i++){
		cout << i << ' ';
		first_stack.push( i ); //insere elemento no topo
	}

	if( first_stack.empty() )
		cout << "Pilha vazia!" << endl;
	else
		cout << "Tamanho da pilha é: " << first_stack.size() << endl;

	cout << "Qual é o topo da pilha?" << endl;
	cout << first_stack.top() << endl;

	//adiciona um novo elemento no topo,
	//mas antes de inserir ele constroí o objeto..
	first_stack.emplace(10);
	cout << "Qual é o topo da pilha?" << endl;
	cout << first_stack.top() << endl;
	if( first_stack.empty() )
		cout << "Pilha vazia!" << endl;
	else
		cout << "Tamanho da pilha é: " << first_stack.size() << endl;
	 
	stack<int> second_stack;
	first_stack.swap(second_stack);

	if( first_stack.empty() )
		cout << "Primeira Pilha vazia!" << endl;
	else
		cout << "Tamanho da primeira pilha é: " << first_stack.size() << endl;

	if( second_stack.empty() )
		cout << "Segunda Pilha vazia!" << endl;
	else
		cout << "Tamanho da segunda pilha é: " << second_stack.size() << endl;

	if (not first_stack.empty()){
		cout << "Retirando elementos da primeira pilha:" << endl;
		popElements( first_stack );
	}

	if (not second_stack.empty()){
		cout << "\nRetirando elementos da primeira pilha:" << endl;
		popElements( second_stack );
	}
	cout << endl;
	return 0;
}

/* define que uma classe qualquer pode ser passada para essa função
 * serve para generalizar uma função quando será usada por mais do que
 * um tipo, equivalente ao void * que usamos em C
 * */
template< class T >
void popElements( T &s ){
	while( not s.empty() ){
		cout << s.top() << ' ';
		s.pop();
	}
}
