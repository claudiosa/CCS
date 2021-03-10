%%% IF YOU WISH ... you can load this way ...
% :- ['test1.pl', '....' ].
% :- ['test2.pl'].
/*
How to use:
?- ['general_search.pl','breadth_first.pl','test1.pl'].
true.

?-  search([[a]], S).
S = [a, f, i] ;
false.

?- ['general_search.pl','breadth_first.pl','test2.pl'].
.................
etc
*/

% search(+Paths, -Solution).
% -- Paths: is a list of lists containing the paths currently being searched.
%    e.g. If Paths = [[c,b,a],[d,b,a]], the list represents two brances of the
%    tree rooted at a and shown below:
%           a
%           |
%           b
%         /   \
%        c     d
%    i.e. the first element of the first list is the latest node being explored
%    by the search for the path represented by that list.
% -- Solution: is a path from the initial to goal state e.g. [a,b,d], 
%    where a is the initial state and d is the goal state.
%
% To call the search we could use a query of the form:
%
% ? search([[a]], S).
%
% where [[a]] represents the root of the tree above (initial state of search).
%
% Case 1: a goal node is found.

search(Paths, Solution):-
	choose([Node|Nodes], Paths, _),
	goal(Node),
	reverse([Node|Nodes], Solution).

% Case 2: carry on searching.
search(Paths, Solution):-
	choose(Path, Paths, RestOfPaths),
	findall([NewNode|Path], expands(Path, NewNode), Expansions),
	combine(Expansions, RestOfPaths, NewPaths),
	search(NewPaths, Solution).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%