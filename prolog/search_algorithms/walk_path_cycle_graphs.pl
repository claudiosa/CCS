/*
Graphs concepts
Ilustrating the "walk", "path" and "cycle" in the graph

*/


%% Graph representation , . 
%:- use_module(library(clpfd)). %%% for future use and extension , , 
% ,  clpfd needs of it , 
%sample( graph( [1->2, 1->3,  2->3, 3->4, 4->6, 6->5, 5->3, 5->1 ] ) ).
%%% OFICIAL GRAPH [1->2,1->3,2->3,3->4,4->6,6->5,5->3,5->1]
sample( graph([ 5->6, 1->2, 1->3, 2->1, 3->4, 4->6, 6->5, 5->3, 5->1, 3->5, 6 -> 7, 7->1]) ).


%%%% Just do deal with DFS ... dynamic data
:- dynamic(edge/2) .
:- initialization(top).

top:- clean_edges, build_edges.

clean_edges :-
        retract(edge(X,Y)), %%% look the dynamic predicate
        format("\n Erasing edge ...: ~w -> ~w",[X,Y]),
        fail.
clean_edges :-  format("\n TABLE of edges clean -- OK").

build_edges :-
        sample( graph( L_ADJ) ),
        do_assert(L_ADJ),
        format("\n TABLE of edges  -- OK").

do_assert([]):- format("\n Edges Loaded ...").
do_assert([A->B| L]):-
        asserta(edge(A,B)),
        do_assert(L).
/* ******************************************************** */


/* *************************************************************************** */
%%% WALK predicate
%% walk[start_node, , , ., end_node]
%% tests
/*
:- sample(G), walk([5,Y,X,6],G). %% it is a walk
:- sample(G), walk([5,3,4,6,5,1,3], G). %% it is a walk
:- sample(G), walk([2,3,1], G). %% NO
*/
%t_OK :- , sample(G), walk([2,3], G).
% walk([], graph( L_ADJ )) :- !.
%% W is a walk for graph?
walk([A,B], graph( L_ADJ )) :- 
            member(A->B , L_ADJ),
            !.

walk([A,C | L], graph( L_ADJ ) ) :- 
                %%% CURRENT, ADJ_MATRIX, NEXT 
                member( A->C , L_ADJ),
                walk( [ C | L ] , graph( L_ADJ ) ).

/* *************************************************************************** */
%% PATH predicate
%% path is sequence not repeated of nodes , different of a walk
%% NONE repetion and with a specific lenght
%% tests
/*
 :-  sample(G), path([5,3,4,6,5,1,3], G). %% it is NOT a PATH , .
 :-  sample(G), path([5,3,4,6], G). %% OK 
*/
%% W is a path, with size/lenght S?
path(W, graph( L_ADJ )) :-
    %% W: sequence the nodes to test .... it is a input
    first_node(W, Start),
    last_node(W,  Target),
    length(W, SIZE), %%% Is there a path W with this SIZE ?????
    %%% using a DFS to check it
    %%% all the solutions must exibhits lenght equal SIZE
    search_DFS(Start, Target, SIZE, [Start], Sol_Inv),
    reverse(Sol_Inv, Solution),
    format("\n Yes, there is a Path: ~w", [Solution]),
    format("\n Graph is: ~w", [L_ADJ])
    .

/* *************************************************************************** */
%% W is a cycle?
%% Cycle is path, where the last node presents a connection with the first node.
%% in this W = [1,2,3,4,6,5] , . if it is cycle and 5->1?
% ?- sample(G), cycle( [1,2,3,4,6,5], G). %%% OK
%% ?- sample(G), cycle( [1,X,Y,Z,W,5], G).

cycle(W, graph( L_adjacency)) :-

        first_node(W, Source),
        last_node(W,  Target),
        member(Target->Source, L_adjacency), %%% the last connected to the first
        %%% REUSING THE PATH definition to check if is path with W
        path(W, graph( L_adjacency )),

        format("\n Yes, it is cycle, ALSO, because : ~w -> ~w", [Target, Source]).

%%%% AUXILIAR PREDICATES
first_node([], _) :- format("\n List W is empty").
first_node([A|_],A) :- nonvar(A),  !.

%%%%% get the last node
last_node([], _) :- format("\n List W is empty"), !.
last_node([A],A) :- nonvar(A), !.
last_node([_|B], C) :-  last_node(B, C) .

/* *************************************************************************** */
/* HERE the DFS - ground part */
search_DFS( _ , Target, Size,  [Current|L] , [Current|L] ) :-  
   %%% analogous an BFS up to SIZE
    Size == 1, %%%% to warranty that all nodes are present in the CYCLE
    %% and only path with this SIZE
    Current == Target.
    % this DFS is Didactial to learn a DFS
    % write(' , , , , , . ONE SOLUTION WAS FOUND , , , , ').

 /* HERE the DFS - recursive part */
  search_DFS( S, T, Size, [Current_NODE | VisitedPath], Solution  ) :-
  
  /*  Find or take a next node */
      edge( Current_NODE, Next ),     
  /* check if the next node  is already visited */
      not( member(Next,  VisitedPath) ),  
      S_New is (Size - 1),
  /* Recursively a new node is explored */
	search_DFS( S,  T, S_New, [Next, Current_NODE | VisitedPath], Solution ).
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% NOT USED
get_pairs([],[]).
get_pairs([Source->Target|L1] , [(Source,Target)|L2] ) :-
   get_pairs(L1,L2).

%next_node(Current, [Current->Next], Next) :- !.
next_node(Current, [], _ ) :- format("\n no CONNECTION for ~w", [Current]).
next_node(Current, [Current -> Next |_ ], Next) :- !.

next_node(Current, [Source-> _ | L ], Next):- 
      Current \== Source,
      next_node(Current, L , Next). %% take the next edge

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
ATTENTION HERE:
https://www.swi-prolog.org/pldoc/doc_for?object=labeling/2
*/
