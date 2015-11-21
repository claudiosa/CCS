
/* CANNIBAL.PL */

/*
 * Main predicate
 */

missionaries_and_cannibals :-
     ferry([[3,3,l,0,0]],Solution),
     fast_reverse(Solution,ReversedSolution),
     show_ferry(ReversedSolution).

/*
 * How to move people across the river
 */

ferry([OldSit|Rest],Solution) :-
     safe_trip(OldSit,NewSit),
     \+ member(NewSit,Rest), /* not .... */
     check_ferry([NewSit,OldSit|Rest],Solution).

safe_trip([ML,CL,l,MR,CR],[MLL,CLL,r,MRR,CRR]) :-
     in_boat(M,C,ML,CL),
     MLL is ML - M,
     CLL is CL - C,
     not_overpowered(MLL,CLL),
     MRR is MR + M,
     CRR is CR + C,
     not_overpowered(MRR,CRR).

safe_trip([ML,CL,r,MR,CR],[MLL,CLL,l,MRR,CRR]) :-
     in_boat(M,C,MR,CR),
     MLL is ML + M,
     CLL is CL + C,
     not_overpowered(MLL,CLL),
     MRR is MR - M,
     CRR is CR - C,
     not_overpowered(MRR,CRR).

/*
 * How to find out whether we've finished
 */

check_ferry([[0,0,r,3,3]|Rest],[[0,0,r,3,3]|Rest]).

check_ferry(SequenceOfSituations,Solution) :-
     ferry(SequenceOfSituations,Solution).

/*
 * Other constraints on putting people in the boat
 */

in_boat(M,C,MM,CC) :- boat_load(M,C), M =< MM, C =< CC.

boat_load(1,0).
boat_load(0,1).
boat_load(1,1).
boat_load(2,0).
boat_load(0,2).

not_overpowered(0,_).
not_overpowered(M,C) :- M >= C.

/*
 * List processing utilities
 */

fast_reverse(X,Y) :- fast_reverse_aux(X,Y,[]).

fast_reverse_aux([],X,X).
fast_reverse_aux([H|T],Result,Temp) :-
     fast_reverse_aux(T,Result,[H|Temp]).

member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).

/*
 * Routines to display the solution as a picture
 */

show_ferry([]).

show_ferry([[ML,CL,B,MR,CR]|Rest]) :-
     nl, nl,
     write_times('M ',ML),
     write_times('C ',CL),
     boat(B,Picture),
     write(Picture),
     write_times('M ',MR),
     write_times('C ',CR),
     show_ferry(Rest).

write_times(_,0).

write_times(X,N) :-      /* write X, N times */
     write(X),
     M is N - 1,
     write_times(X,M).

boat(l,'\(___)                    / ').
boat(r,'\                    (___)/ ').
/*************************************************/
