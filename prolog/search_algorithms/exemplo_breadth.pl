
#  A small program illustrating breadth first  search , with example data for a
%"ferry route" puzzle and the Jugs puzzle from the text. Can trivially be
%modified for depth first search.

% search(+StartNode, ?EndNode, ?Soln).
% Finds path (Soln) between StartNode and EndNode 
% e.g., ?- search([4,0], [2,_], Soln).

search(Start, End, Soln) :-
  agenda_search([[Start]], End, Soln).

% agenda_search(+StartAgenda, ?Target, ?Soln).
% Given an agenda of paths, it will find  a Soln which is a path which 
% extends one of the paths on the agenda, and whose first node is a valid 
% Target state.

agenda_search([[State|Rest]|_], Target, [State|Rest]) :- 
	reached_target(State, Target).

agenda_search([Path|Paths], End, Soln) :-
   extend(Path, ExtendedPaths),
   append(Paths, ExtendedPaths, NewPaths),
   agenda_search(NewPaths, End, Soln).

% extend(+Path,?ExtendedPaths)
% Extended paths will be set of all paths one node (NewNode) longer than 
% Path, such that there is a link from the first node in Path to the new node,
% and no loops in the path.

extend([Node|RestPath], ExtendedPaths) :-
   bagof([NewNode,Node|RestPath],
         (successor(Node, NewNode), 
          \+ member(NewNode, [Node|RestPath])),   
	 ExtendedPaths), !.               
extend(_,[]).

% reached_target(State, Target)
% Succeeds if State is a Target state.
% For simple state-space search this is just if they are the same.

reached_target(State, State).

% Successor relation for ferry problem

ferry_route(piraeus, syros).
ferry_route(syros, paros).
ferry_route(paros, naxos).
ferry_route(naxos, amorgos).
ferry_route(naxos, santorini).
ferry_route(milos, santorini).
ferry_route(piraeus, kythnos).
ferry_route(piraeus, milos).
ferry_route(serifos, milos).
ferry_route(paros, serifos).

successor( X, Y) :- ferry_route(X, Y).
successor( X, Y) :- ferry_route(Y, X).


% Successor relation for water jugs problem

successor([X,_],[X,0]). % Pour out 3 gallon jug
successor([_,Y],[0,Y]). % Pour out 4 gallon jug
successor([X,_],[X,3]). % Fill 3 gallon jug
successor([_,Y],[4,Y]). % Fill 4 gallon jug
successor([X,Y],[NewX,0]) :-
	NewX is X+Y, NewX < 4.  % Pour all 3 gallon into 4 gallon
successor([X,Y],[0,NewY]) :-
	NewY is X+Y, NewY < 3.  % Pour all 4 gallon into 3 gallon
successor([X,Y],[NewX,3]) :-
	NewX is X-3+Y, NewX > 0.   % Pour 4 gall into 3 gall until 3 gal full.
successor([X,Y],[4,NewY]) :-
	NewY is Y-4+X, NewY > 0.   % Pour 3 gall into 4 gall until 4 gal full.



% Utilities

member(H,[H|_]).
member(H,[_|T]) :- member(H, T).

append([],L,L).
append([H|T],L,[H|R]) :- append(T, L, R).


