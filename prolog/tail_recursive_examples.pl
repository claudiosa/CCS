tail_s(N, S) :- s(N,0, S),
format('\n The sum from 0 up to: ~w  is: ~w', 
    [N, S]).


%%%%%%% tail recursive
s(0,S,S) :- !. %% to finish this sum
s(N, Temp, S) :- 
    N >= 1,	
	ACC is (N + Temp),
	N_new is (N-1),
	s(N_new, ACC, S).
	

tail_fat(N, F) :- fat(N,1, F),
format('\n The fatorial of: ~w  is: ~w',  [N, F]).

%%%%%%% tail recursive
fat(0,F,F) :- !. %% to finish this sum
fat(N, Temp, S) :- 
    N >= 1,	
	ACC is (N * Temp),
	N_new is (N-1),
	fat(N_new, ACC, S).
	    