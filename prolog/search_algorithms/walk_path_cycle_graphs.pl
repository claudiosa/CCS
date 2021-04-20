/*

Ilustrating the "walk", "path" and "cycle" in the graph

*/


%% Graph representation ... 
:- use_module(library(clpfd)). %%% for future use and extension ....
% .. clpfd needs of it ..
ex1( graph(1..6,[1->2,1->3,2->3,3->4,4->6,6->5,5->3,5->1]) ).
ex2( graph(1..7,[5->6, 1->2 ,1->3 ,2->3 ,3->4 , 4->5, 6->5, 5->3, 5->1, 3->5,  6->7, 7->1]) ).
/*
?- listing(ex2/1).
ex2(graph(1..7, [(1->2),  (1->3),  (2->3),  (3->4),  (4->5),  (6->5),  (5->3),  (5->1),  (3->5),  (5->6),  (6->7),  (7->1)])).
*/
/* *************************************************************************** */
%%% WALK predicate
%% walk[start_node, ....., end_node]
%% tests
/*
:- ex1(G), walk([5,Y,X,6],G). %% it is a walk
:- ex1(G), walk([5,3,4,6,5,1,3], G). %% it is a walk
:- ex1(G), walk([2,3,1], G). %% NO
*/
%t_OK :- ex1(G), walk([2,3], G).
% walk([], graph(_..Nodes, L_ADJ )) :- !.
%% W is a walk for graph?
walk([A,B], graph(_..Nodes, L_ADJ )) :- 
            member(A->B , L_ADJ),
            !.

walk([A,C | L], graph(_..Nodes, L_ADJ)) :- 
                %%% CURRENT, ADJ_MATRIX, NEXT 
                member(A->C, L_ADJ),
                walk( [ C | L ] , graph(_..Nodes, L_ADJ) ).

/* *************************************************************************** */
%% PATH predicate
%% path is sequence not repeated of nodes ...different of a walk
%% NONE repetion
%% tests
/*
 :- ex1(G), path([5,3,4,6,5,1,3], G). %% it is NOT a PATH ...
 :- ex1(G), path([5,3,4,6], G). %% OK 
*/
%% W is a path?
path(W, graph(_..Nodes, L_adjacency)) :-
    first_node(W, Source),
    last_node(W,  Target),
    length(W, Size),
    %%% using a DFS to check it
    search_DFS(Source, Target, L_adjacency, Size, [Source], Sol_Inv),
    reverse(Sol_Inv, Solution),
    format("\n Yes, there is a Path: ~w", [Solution]).

/* *************************************************************************** */
%% W is a cycle?
%% Cycle is path, where the last node presents a connection with the first node.
%% in this W = [1,2,3,4,6,5] ... if it is cycle and 5->1?
% :- ex1(G), cycle( [1,2,3,4,6,5], G). %%% OK

cycle(W, graph(_..Nodes, L_adjacency)) :-
        path(W, graph(_..Nodes, L_adjacency)), %%% condition to be a path
        first_node(W, Source),
        last_node(W,  Target),
        member(Target->Source, L_adjacency), %%% the last connected to the first
        format("\n Yes, it is cycle, also, because : ~w -> ~w", [Target, Source]).


%%%% AUXILIAR PREDICATES
first_node([], _) :- format("\n List W is empty").
first_node([A|_],A) :- nonvar(A),  !.

%%%%% get the last node
last_node([], _) :- format("\n List W is empty"), !.
last_node([A],A) :- nonvar(A), !.
last_node([_|B], C) :-  last_node(B, C) .

/* *************************************************************************** */
/* HERE the DFS - ground part */
search_DFS( _ , Target, _ , Size, [Current|L] , [Current|L] ) :-  
   %%% analogous an BFS up to SIZE
    Size == 1, %%%% to warranty that all nodes are present in the CYCLE
    Current == Target.
    %  this DFS is Didactial to learn a DFS
    % write(' ........... ONE SOLUTION WAS FOUND ........').

 /* HERE the DFS - recursive part */
  search_DFS( S, T, L_ADJ, Size, [Current_NODE | VisitedPath], Solution  ) :-
  
  /*  Find or take a next node */
      next_node( Current_NODE, L_ADJ, Next ),     
    
  /* check if the next node  is already visited */
      not( member(Next, VisitedPath) ),  
  /* Size is initial lenght of a path or cycle */
      New_Size is (Size - 1),  
   /* Recursively a new node is explored */
	search_DFS(S, T, L_ADJ, New_Size, [Next, Current_NODE | VisitedPath], Solution ).
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%next_node(Current, [Current->Next], Next) :- !.
next_node(Current, [], _ ) :- format("\n no CONNECTION for ~w", [Current]).
next_node(Current, [Current -> Next |_ ], Next) :- !.

next_node(Current, [Source-> Target | L ], Next):- 
      Current \== Source,
      next_node(Current, L , Next). %% take the next edge

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% NOT USED
get_pairs([],[]).
get_pairs([Source->Target|L1] , [(Source,Target)|L2] ) :-
   get_pairs(L1,L2).

/*
NOT USED
walk(W, graph(_..Nodes, L_adjacency)) :-
   % write(Nodes), 
   % nl, write(W), 
    first_node(W, Source),
    last_node(W,  Target),
    length(W, Size),
   % nl, write(L_adjacency),
    search_DFS(Source, Target, L_adjacency, Size, [Source], Sol_Inv),
    reverse(Sol_Inv, Solution),
    nl, write(W),
    %format(" = ~w", [Solution]).
    format("\n One solution is: ~w", [Solution]).
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



/*
ATTENTION HERE:
https://www.swi-prolog.org/pldoc/doc_for?object=labeling/2
*/
