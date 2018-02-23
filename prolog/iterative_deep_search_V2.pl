% Computational Intelligence: a logical approach. 
% Prolog Code. 
% Iterative deepening search, based on Prolog doing the searching.
% Copyright (c) 1998, Poole, Mackworth, Goebel and Oxford University Press.

% idsearch(N,P) is true if path P is a path from
% node N to a goal, found using iterative deepening search
% Example query: idsearch2(o103,P).
idsearch2(N,P) :-
   idsearch(N,0,P).

% failed(naturally) is true if the depth bound
% was not reached in the current iteration.
% failed(unnaturally) is true if the search failed
% because the search hit the depth-bound.
:- dynamic failed/2.    ;; this is not actually needed!

% idsearch(N,DB,P) is true if there is a path from
% N to a goal with path length greater than or
% equal to DB
idsearch(N,DB,P) :-
   assert(failed(naturally)),
   dbsearch(N,DB,P).

idsearch(N,DB,P) :-
   retract(failed(How)),
   how=unnaturally,
   DB1 is DB+1,
   idsearch(N,DB1,P).

% dbsearch(N,DB,P) is true if path P is a path of
% length DB from N to a goal.
dbsearch(N,0,[N]) :-
   is_goal(N).
dbsearch(N,0,_) :-
   retract(failed(_)),
   assert(failed(unnaturally)),
   fail.
dbsearch(N,DB,[N|P]) :-
   DB>0,
   neighbours(N,NNs),
   member(NN,NNs),
   DB1 is DB-1,
   dbsearch(NN,DB1,P).

% member(E,L) is true if E is a member of list L
member(E,[E|_]).
member(E,[_|L]) :-
   member(E,L).
