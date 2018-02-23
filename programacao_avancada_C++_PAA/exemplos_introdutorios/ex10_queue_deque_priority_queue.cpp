#include <iostream>
#include <deque>
#include <queue> /*priority_queue and queue*/


/*
 * Deque possuí acesso aleatório.
 *
 * Priority_queue e Queue não possuem iteradores.
 * 
 * */

using namespace std;

struct compare{  
	bool operator()(const int& l, const int& r){  
		return l > r;  
	}
};

template< class T >
void popElements( T &s );

int main(void){
	cout << "\n____________________QUEUE__________________________________" << endl;
	/*
	 * FIFO (First in, First out); 
	 * Queue Functions: empty, size, front, back, push, emplace, 
	 * pop, swap
	 * */
	queue<int> queue_T;
	
	for(int i = 0; i < 10; i++)
		queue_T.push(i);//vai add sempre no final, fifo;
	
	cout << "Primeiro Elemento: " << queue_T.front() << endl;
	cout << "Ultimo Elemento: " << queue_T.back() << endl;
	
	while( not queue_T.empty() ){
		cout << queue_T.front() << ' ';
		queue_T.pop();
	}
	cout << endl;
	cout << endl;
	cout << endl;
	cout << "\n________________Priority_QUEUE_____________________________" << endl;
	
	priority_queue<int,vector<int>, compare > pq;  

	pq.push(3);  
	pq.push(5);  
	pq.push(1);  
	pq.push(8);  
	while ( not pq.empty() ){  
		cout << pq.top() << endl;  
		pq.pop();  
	}
	cout << endl;
	cout << endl;
	cout << endl;
	cout << endl;
	//maior pro menor
	cout << "\n________________PQ greater to less ________________________" << endl;
	priority_queue<int,vector<int>, less<int> > pqp;
	pqp.push(3);  
	pqp.push(5);  
	pqp.push(1);  
	pqp.push(8);  
	while ( not pqp.empty() ){  
		cout << pqp.top() << endl;  
		pqp.pop();  
	}
	//menor pro maior
	cout << "\n________________PQ less to greater ________________________" << endl;
	priority_queue<int,vector<int>, greater<int> > pqpp;
	pqpp.push(3);  
	pqpp.push(5);  
	pqpp.push(1);  
	pqpp.push(8);  
	while ( not pqpp.empty() ){  
		cout << pqpp.top() << endl;  
		pqpp.pop();
	}	
	cout << "\n____________________DEQUE__________________________________" << endl;
	/*
	 * Deque Functions: begin, end, rbegin, rend, size, resize, empty
	 * [], at, front, back, push_back, push_front, pop_front,
	 * insert, erase, swap, clear, emplace, emplace_front,
	 * 
	 * */
	deque<int> deque_1;
	for( int i = 50; i < 100; i++ )
		deque_1.push_back(i);//insere no final
	
	for( int i = 49; i >= 0; i-- )
		deque_1.push_front(i);//insere no inicio
		
	cout << "Primeiro elemento: " << deque_1.front() << endl;
	cout << "Ultimo elemento: " << deque_1.back() << endl;
	
	deque<int>::iterator it;
	deque<int>::reverse_iterator it2;
	
	cout << "\nPercorrendo com iterador normal:" << endl;
	for(it = deque_1.begin(); it != deque_1.end(); it++)
		cout << *it << ' ';
	
	cout << "\n\nPercorrendo com iterador reverso:" << endl;
	for(it2 = deque_1.rbegin(); it2 != deque_1.rend(); it2++)
		cout << *it2 << ' ';
	
	cout << "\n___________________________________________________________" << endl;
	
	
	return 0;
}

template< class T >
void popElements( T &s ){
	while( not s.empty() ){
		cout << s.top() << ' ';
		s.pop();
	}
}

