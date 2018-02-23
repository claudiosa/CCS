/* MODIFICADO ===> para o SWI-Prolog */
%%%%%%%%%%%%%%%%%%%% stack operations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% These predicates give a simple, list based implementation of stacks
	% empty stack generates/tests an empty stack
empty_stack([]).
	% member_stack tests if an element is a member of a stack
member_stack(E, S) :- member(E, S).
	% stack performs the push, pop and peek operations
	% to push an element onto the stack
		% ?- stack(a, [b,c,d], S).
	%    S = [a,b,c,d]
	% To pop an element from the stack
	% ?- stack(Top, Rest, [a,b,c]).
	%    Top = a, Rest = [b,c]
	% To peek at the top element on the stack
	% ?- stack(Top, _, [a,b,c]).
	%    Top = a 

stack(E, S, [E|S]).

%%%%%%%%%%%%%%%%%%%% queue operations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% These predicates give a simple, list based implementation of 
	% FIFO queues
	% empty queue generates/tests an empty queue
empty_queue([]).

	% member_queue tests if an element is a member of a queue
member_queue(E, S) :- member(E, S).

	% add_to_queue adds a new element to the back of the queue
add_to_queue(E, [], [E]).
add_to_queue(E, [H|T], [H|Tnew]) :- add_to_queue(E, T, Tnew).

	% remove_from_queue removes the next element from the queue
	% Note that it can also be used to examine that element 
	% without removing it
remove_from_queue(E, [E|T], T).
append_queue(First, Second, Concatenation) :- 
	append(First, Second, Concatenation).

%%%%%%%%%%%%%%%%%%%% set operations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% These predicates give a simple, 
	% list based implementation of sets
	
	% empty_set tests/generates an empty set.
empty_set([]).

member_set(E, S) :- member(E, S).
	% add_to_set adds a new member to a set, allowing each element
	% to appear only once

add_to_set(X, S, S) :- member(X, S), !.
add_to_set(X, S, [X|S]).

remove_from_set( _ , [], []).
remove_from_set(E, [E|T], T) :- !.
remove_from_set(E, [H|T], [H|T_new]) :-
	remove_from_set(E, T, T_new), !.
	
uniao([], S, S).
uniao([H|T], S, S_new) :- 
        uniao(T, S, S2),
	add_to_set(H, S2, S_new).	
	
intersecao([], _, []).
intersecao([H|T], S, [H|S_new]) :-
	member_set(H, S),
        intersecao(T, S, S_new),!.
intersecao([_|T], S, S_new) :-
        intersecao(T, S, S_new),!.
	
set_diff([], _, []).
set_diff([H|T], S, T_new) :- 
	member_set(H, S), 
	set_diff(T, S, T_new),!.
set_diff([H|T], S, [H|T_new]) :- 
	set_diff(T, S, T_new), !.

sub_set([], _).
sub_set([H|T], S) :- 
	member_set(H, S), 
        sub_set(T, S).

equal_set(S1, S2) :- 
        sub_set(S1, S2), sub_set(S2, S1).
	
%%%%%%%%%%%%%%%%%%%%%%% priority queue operations %%%%%%%%%%%%%%%%%%%
	% These predicates provide a simple list based implementation
	% of a priority queue.
	
	% They assume a definition of precedes for the objects being handled
empty_sort_queue([]).

member_sort_queue(E, S) :- member(E, S).

insert_sort_queue(State, [], [State]).	
insert_sort_queue(State, [H | T], [State, H | T]) :- 
	precedes(State, H).
insert_sort_queue(State, [H|T], [H | T_new]) :- 
	insert_sort_queue(State, T, T_new).	
	
remove_sort_queue(First, [First|Rest], Rest).

/*************************************************/

 
