
/*
=.. 	 	 xfx 	 Pred. 	 Convert between a structure and a list
Algo bidirecional 
*/

t([1,2,3,[11,12,13]]).
u( (1,2,(9), (1,2,3, (1,2,3,(4),(666)) ) ) ).
x1 :- 
    t(Vars),
   	Board =.. [Vars],
	write(Board).

x2 :- 
    u(Vars),
	Board =.. [Vars],
	write(Board).
	
	
/*	

?- X =.. [(4,5,(6))].
X = (4, 5, 6).

?- X =.. [(4,5,(6,(7)))].
X = (4, 5, 6, 7).

?- x1.
[1, 2, 3, [11, 12, 13]]
true.


?- x2.
1, 2, 9, 1, 2, 3, 1, 2, 3, 4, 666
true.

?- 
*/
