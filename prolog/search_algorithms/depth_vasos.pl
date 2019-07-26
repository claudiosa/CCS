/* problema dos vasos ... um de 4 litros e o outro de 3 litros
   como encontrar 2 litros em um deles ao final... */


/*

http://www.cse.unsw.edu.au/~billw/cs9414/notes/search/search.html

solve(Node, Solution) :-
  depthfirst([], Node, Solution).

% depthfirst(Path, Node, Solution).
%
% find a Solution path from the current Node to a goal Node - Path
% holds the list of nodes previously traversed (initially []).

depthfirst(Path, Node, [Node|Path]) :-
                        goal(Node).
depthfirst(Path, Node, Sol) :-
  edge(Node, Node1),
  not(member(Node1, Path)),
  depthfirst([Node|Path], Node1, Sol).


edge(1, 2).         %        1
edge(1, 3).         %       / \
edge(2, 4).         %      2   3
edge(3,5).          %      |   |
edge(5,6).          %      4   5
goal(6).            %          |
                    %          6 <- goal
*/


inicio :- busca(vaso(0,0),[vaso(0,0)]).

busca( vaso(X,_) ,  L):-
			X==2, nl, 
			reverse(L,L_invertida),
			w_lst(L_invertida), nl, 
			write('Sucesso').

/*
ou 2 litros no vaso B
busca( vaso(X,Y) ,  L) :-   Y==2, nl  , write('Sucesso'),   write(L).
*/

busca( vaso(X,Y) , L ) :-
        acao( vaso(X,Y), vaso(W,Z)),
	\+ member2( vaso(W,Z), L ),
	busca( vaso( W,Z) ,  [vaso(W,Z) | L]).

/* encheu o vaso A */
acao( vaso( X , Y ) , vaso( 4 , W ) ) :-  X < 4, W is Y.
/* a mesma regra reescrita e simplificada */
acao( vaso( _ ,Y ) , vaso( 4 , Y ) ).

acao( vaso( X ,Y ) , vaso( W , 3  ) ) :-  Y < 3, W is X.

/* esvaziandos os vasos */
acao( vaso( X,Y ), vaso( 0 , Y) ) :- X > 0.
acao( vaso(X ,Y ), vaso( X , 0) ) :- Y > 0.

/* despejando o conteudo de um vaso em outro , com sobras */
acao( vaso( X  , Y ) , vaso(4 , W) ) :-   
		    	Y > 0,
			X + Y > 4,
			W is (Y-(4-X)).

acao( vaso( X , Y) , vaso( W  , 3 ) ):-   
			X  >  0,		
			X + Y > 3,
			W is (X-(3-Y)).
			
/* despeja uma certa quantidade ... ... sem sobras */
acao( vaso( X , Y) , vaso( W  , 0 ) ):-   
		       Y > 0,
			X + Y =< 4,
			W is (X+Y).

acao( vaso( X , Y) , vaso( 0, W ) ):-   
		       X > 0,
         		X + Y =< 3,
			W is (X+Y).

/* movimentos finais..... ===> 2 litros no vaso A */
acao( vaso( _,2 ), vaso(0 ,2) ).
acao( vaso( 0, 2 ), vaso(2 ,0) ).


member2(X, [X|_]).  /* % X is the first element.*/
member2(X, [_|T]) :-
        member2(X, T).  /* % X belongs to the tail.*/

w_lst([]).
w_lst([X|L]) :- nl, write('===> '), write(X), w_lst(L).

