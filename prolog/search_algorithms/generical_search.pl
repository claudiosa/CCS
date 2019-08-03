% Computational Intelligence: a logical approach. 
% Prolog Code. The generic graph searcher from Section 4.3.
% Copyright (c) 1998, Poole, Mackworth, Goebel and Oxford University Press.

% search(M,F,V) is true if there is a path from F to a goal node.
%  M is the search method. It is one of {depth,breadth,heuristic_depth,best}
%  V is the list of all nodes expanded (not just on the path found).

% This traces the frontier as the search proceeds.

% To seach from a node o103, issue the query:
% ? search(depth,[o103],S).
% ? search(breadth,[o103],S).

search(M,F,[N]) :-
   writeln(['Frontier: ',F]),
   select(M,N,F,_),
   is_goal(N).
search(M,F,[N|P]) :-
   select(M,N,F,F1),
   neighbours(N,NN),
   add_to_frontier(M,NN,F1,F2),
   search(M,F2,P).

% select(M,E,F,NF) is true if E is an element of frontier F and NF is
%   the remaining frontier after E is removed. M is the search method used.
% In each of these the frontier is the list of elements in order they
%   are to be chosen.

select(_,N,[N|F],F).

% add_to_frontier(M,N,F1,F2) is true if when using search method M, when
%   nodes N are added to frontier F1, the resulting frontier is list F2.

add_to_frontier(depth,N,F1,F2) :- !,
   append(N,F1,F2).

add_to_frontier(breadth,N,F1,F2) :- !,
   append(F1,N,F2).

add_to_frontier(heuristic_depth,N,F1,F2) :- !,
   mergeinto1(N,[],NF),
   append(NF,F1,F2).

add_to_frontier(best,N,F1,F2) :-
   mergeinto1(N,F1,F2).

% mergeinto1(NL,F1,F2) is true if when NL is added to F1, the result is F2,
%   assuming F1 is in sorted order of h, F2 will be in order of h.
mergeinto1([],L,L).
mergeinto1([H|T],L1,L3) :-
   insertinto1(H,L1,L2),
   mergeinto1(T,L2,L3).

% insertinto1(N,F1,F2) is true if F2 contains the elements of F1 with
%   node N inserted into the position determined by the heuristic value of N
insertinto1(E,[],[E]).
insertinto1(N,[N1|R],[N,N1|R]) :-
   h(N,NC),
   h(N1,NC1),
   NC =< NC1.
insertinto1(N,[N1|R],[N1|R1]) :-
   h(N,NC),
   h(N1,NC1),
   NC > NC1,
   insertinto1(N,R,R1).

% **************************************************
% psearch is like search, but elements of the frontier are of the form: 
% node(Node,Path,Pathcost)
%   where Node is the current node, Path is the path found to Node,
%   (in reverse order) and Pathcost is the cost of the path

% psearch(M,F,S) means method M from frontier F results in path S to goal.
%   This only works for methods in {breadth,depth}. Exercise: fix it.

% To seach from a node s, issue the query:
% ? psearch(depth,[node(o103,[],0)],P).

psearch(M,F,[N|P]) :-
   writeln(['Frontier: ',F]),
   select(M,node(N,P,_),F,_),
   is_goal(N).
psearch(M,F0,S) :-
   select(M,node(N,P,PC),F0,F1),
   neighbours(N,NN),
   add_paths(NN,node(N,P,PC),NF),
   add_to_frontier(M,NF,F1,F2),
   psearch(M,F2,S).

% add_paths(Ns,node(N,P,PC),NF) is true if NF is the list of new
% frontier elements to replace frontier element node(N,P,PC) for each
% node in Ns, where Ns is a list of neighbors of node N.

add_paths([],_,[]).
add_paths([M|R],node(N,P,PC),[node(M,[N|P],NPC)|FR]) :-
   cost(N,M,C),
   NPC is PC + C,
   add_paths(R,node(N,P,PC),FR).

% **************************************************
% Auxiliary definitions

% append(A,B,R) is true if R is the list containing the elements of A followed by the elements of B
append([],R,R).
append([H|T],L,[H|R]) :-
   append(T,L,R).

% writeln(L) is true if L is a list of items to be written on a line, followed by a newline.
writeln(L) :- writel(L),nl.

writel([]).
writel([H|T]) :- write(H), writel(T).
