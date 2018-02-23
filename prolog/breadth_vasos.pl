/* problema dos vasos ... um de 4 litros e o outro de 3 litros
   como encontrar 2 litros em um deles ao final... */


/*

http://www.cse.unsw.edu.au/~billw/cs9414/notes/search/search.html
  
 
% solve(Start, Solution).
%  Solution = path Start to goal (in reverse order).

solve(Start, Solution) :-
  breadthfirst([[Start]], Solution).

% breadthfirst([Path1, Path2, ...], Solution).
%  Solution = extension of one of the paths to a goal.

breadthfirst([[Node|Path]|_], [Node|Path]) :-
  goal(Node).
% Always first check if goal already reached!
% If not, then extend this path by all possible edges, put these
% new paths on the end of the queue (Paths1) to check, and do
% breadthfirst on this new collection of paths, Paths1:
breadthfirst([Path|Paths], Solution) :-
  extend(Path, NewPaths),
  conc(Paths, NewPaths, Paths1),
  breadthfirst(Paths1, Solution).

% extend([N|Rest], NewPaths).
% Extend the path [N|Rest] using all edges through N
% not already on the path, producing a list NewPaths.
extend([Node|Path], NewPaths) :-
  findall([NewNode, Node|Path],
          (edge(Node, NewNode),
           not(member(NewNode,[Node|Path]))),
          NewPaths),
  !.
extend(Path,[]). % findall failed: no edge

edge(1, 2). edge(1, 3).   %     1
edge(2, 4). edge(3, 5).   %    / \
edge(5, 6).               %   2   3
                          %   |   |
goal(3).                  %   4   5
                          %       |
                          %       6 
    
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

