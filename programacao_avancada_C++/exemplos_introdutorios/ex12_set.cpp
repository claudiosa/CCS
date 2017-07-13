#include <iostream>
#include <set>
#include <algorithm>
#include <iterator>

using namespace std;
typedef pair <int, int> ii;


int main(int argc, char **argv){


	int a[10] = {7, 2, 30, 30, 30, 42, 100, 200, 85, 1};

	//A principal diferença entre multiset e set é que multiset 
	//permite dois elementos com chaves iguais
	//multiset <tipo do dado, função de comparação para ordenar os elementos>
	multiset<int, less <int> > ims;
	set<int, less<int> > teste;
	teste.insert(10);
	teste.insert(10);
	ostream_iterator<int> output(cout, " ");

	cout << "Após o insert o set contém: " << endl;
	copy ( teste.begin(), teste.end(), output );
	cout << endl;
	
	cout << "O multiset contêm " << ims.size() << " elementos";

	
	ims.insert( 15 );
	ims.insert( 15 );

	cout << "Procurando quantos elementos iguais têm no set:" << endl;
	cout << "Existem " << ims.count(15) << " elementos de valor 15 no set" << endl;

	cout << "Procurando se existem elementos no set: " << endl;
	//o comando find retorna um iterador para o primeiro elemento encontrado;
	multiset<int>::iterator it = ims.find(15);

	if( it != ims.end() ){
		cout << "Valor encontrado." << endl;
	}else{
		cout << "Valor não encontrado." << endl;
	}

	ims.insert(a, a + 10);
	//define um iterator para saída padrão;
	//cout < padrão, o segundo argumento é o que tu quer colocar apos cada elemento.
	//ostream_iterator<int> output(cout, " ");

	cout << "Após o insert o set contém: " << endl;
	copy ( ims.begin(), ims.end(), output );
	
	cout << endl;

	cout << "Limite inferior de 30: " << endl;
	cout << *( ims.lower_bound(30) ) << endl;
	cout << "Limite superior de 30: " << endl;
	cout << *( ims.upper_bound(30) ) << endl;
	
	pair < multiset<int>::iterator, multiset<int>::iterator> p;
	
	p = ims.equal_range(30);
	cout << "Limite inferior de 30: " << endl;
	cout << *p.first << endl;
	cout << "Limite superior de 30: " << endl;
	cout << *p.second << endl;
	
	//apaga um elemento qualquer
	ims.erase(30);
	cout << "Após o erase o set contém: " << endl;
	//imprime na tela
	copy ( ims.begin(), ims.end(), output );
	cout << endl;
	//limpa o set todo
	ims.clear();
	cout << "Após o clear o set contém: " << endl;
	copy ( ims.begin(), ims.end(), output );

	return 0;
}

