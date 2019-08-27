

w_l(0).
w_l(N) :- N > 0,
		  write('#'),
		  write(' '),
		  Ant is (N-1),
		  w_l(Ant).
		  
		  
t(0).		  
/*t(1) :- w_l(1).		   	

t(2) :- t(1), nl, w_l(2).
*/
t(N) :- w_l(N),
        nl,
		N > 0,
		Ant is (N-1),
		t(Ant).

