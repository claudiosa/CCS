#include <iostream>
#include <map>

using namespace std;

typedef multimap<int, double, less<int> > mmid;
typedef pair<int, double> pid;
typedef multimap<mmid, int> t1;
typedef multimap<int, mmid> t2;

int main(){
	mmid pairs;

	cout << "Atualmente existem: " << pairs.count(15)
		 << " pares com a chave 15 no mapa" << endl;

	pairs.insert(mmid::value_type(15, 2.7));
	//ou
	pairs.insert(make_pair(15, 2.7));
	//ou
	pid par = make_pair(20, 3.8);
	pairs.insert(par);
	
	//poderia também ter um mapa como chave
	t1 teste1;
	teste1.insert(t1::value_type(pairs, 10));
	//ou um mapa como valor :) 	
	t2 teste2;
	teste2.insert(t2::value_type(10, pairs));
	
	cout << "Apos os inserts existem: " << pairs.count(15);
	cout << " pares com a chave 15" << endl;
	double j = 0.0;
	for(int i = 0; i < 20; i++, j+=0.3){
		pairs.insert(mmid::value_type(i, j));
	}
	
	cout << "Chave\tValor" << endl;
	for(mmid::iterator it = pairs.begin(); it != pairs.end(); it++)
		cout << it->first << "\t" << it->second << endl;

	cout << "Ao contrário:" << endl;
	cout << "Chave\tValor" << endl;
	for(mmid::reverse_iterator it = pairs.rbegin(); it != pairs.rend(); it++)
		cout << it->first << "\t" << it->second << endl;

	mmid::iterator it = pairs.find(3);

	if(it != pairs.end() )
		cout << "Encontrou: " << it->first << " " << it->second << endl;
	return 0;
}

