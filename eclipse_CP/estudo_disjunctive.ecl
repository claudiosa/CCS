:- lib(ic).
:- lib(ic_edge_finder3).

go :-
	[A,B] :: 0..60,
	A #> 40,
	B #> A,
	disjunctive([A,B],[10,15]),
	labeling([A,B]),
	writeln("...aA  ...bB " : A : B).

/*    
The declarative meaning is that the N tasks with the given start 
times and durations do not overlap at any point in time, i.e. 
for any pairs of tasks X and Y, the following holds:

C1: (Xstart + Xduration =< Ystart) or 
C2: (Ystart + Yduration =< Xstart)
 
No exemplo acima: Xstart = A  e Ystart = B
*/
