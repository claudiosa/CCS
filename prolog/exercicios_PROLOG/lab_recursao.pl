
s(1,1).

s(N,S) :- N>1, Ant is (N-1),
	      s(Ant, Sant),
		  S is (Sant + N).
