% expands(+Path, ?NewNode).
% -- Path: is a list of nodes of the form Path=[Node|Nodes], where
%    Node is the node we want to expand and Nodes is a list
%    of remaining nodes already expanded and containing the root.
% -- NewNode: is a constant representing the node we want to go to,
%    as there is an link to it from where we are currently.
%
expands([Node|L], NewNode):-
	connected(Node,NewNode),
	not(member(NewNode, L)),
	arc(Node, NewNode).

%
% *Predicates to define in separate files for breadth_first and depth_first*
%
% choose(+Path, +Paths, ?RestPaths).
% -- Path: is a list containing path for the search to consider.
% -- Paths: is a list of lists (paths) that we need to select the Path from.
% -- RestPaths: are the paths that remain from Paths once we select Path.

%% BFS
% choose(Path, Paths, RestOfPaths)
choose( A , [A | L_All], L_All ):-!.
choose( [A|L], [ [A,X|L]| L_All],  L_All):-
	connected(A,X),
	not(member(X, L)),
    choose( L , [ L | L_All], L_All).

%% it is already in the path
choose( L , [ [ _ | L] | L_All],  L_All):-
	choose( L , [ L | L_All ] , L_All).


%%% the modeling of objects
connected(X,Y) :- arc(X,Y).
connected(X,Y) :- arc(Y,X).

%start_node(a).
%end_node(X) :- goal(X).

%
% NEED TO DEFINE THIS PREDICATE YOURSELVES FOR TASK 1 OF COURSEWORK.
%...

% combine(+Expansions, +RestOfPaths, ?NewPaths).
% -- Expansions: is a list of lists containing possible new paths to consider.
% -- RestOfPaths: are the rest of the paths that need that remain unexplored.
% -- NewPaths: are the Expansions and the RestOfPaths merged. NOTE: for
%    breadth-first the NewPaths is FIFO, while for depth-first is a LIFO.
%
% NEED TO DEFINE THIS PREDICATE YOURSELVES FOR TASK 1 OF COURSEWORK.
%...
%
combine(Expansions, RestOfPaths, NewPaths) :-
	append(Expansions, RestOfPaths, NewPaths).