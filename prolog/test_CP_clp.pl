%% USAGE:
/*

%%$ time(swipl -f diff_CP_search.pl -t go1)

%% TRAP of PL
%%$ time(swipl -f diff_CP_search.pl -t go2)
$ time(swipl -f diff_CP_search.pl -t go2)
..............
after almost 3 min
..............
===============
[9,5,6,7,1,0,8,2]
===============
% halt

real	2m17,524s
user	2m17,164s
sys	0m0,047s


%% with CP
$ time(swipl -f diff_CP_search.pl -t go)

*/
%:- use_module(library(clpfd)).


%graph(1..6,[1->2,1->3,2->3,3->4,4->6,6->5,5->3,5->1])
g([1->2,1->3,2->3,3->4,4->6,6->5,5->3,5->1]).
%%%atom_char(A,C)
go :-       g(L1), 
            get_pairs(L1,L2),
            format("\n Reading a graph: ~w",[L1]),
            format("\n Transformed in PAIRS (easy to work): ~w",[L2]).


get_pairs([],[]).
get_pairs([Source->Target|L1] , [(Source,Target)|L2] ) :-
   get_pairs(L1,L2).



/*
ATTENTION HERE:
https://www.swi-prolog.org/pldoc/doc_for?object=labeling/2
*/
