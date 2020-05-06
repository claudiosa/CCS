
v_Y(N,N) :- !.
v_Y(N, END) :- 
          N =< END ,
		  writeln('y....N' : N),
		  Next is (N+1),
		  v_Y(Next, END).

i1 :- v_Y(1,6).		  
i2 :- v_XY(1,3,1,4).

v_XY(N,N, _, _ ) :- !.
v_XY(N, END, Y, END_Y) :- 
              N =< END ,
              writeln('x.........X' : N),
              v_Y(Y,END_Y),
              Next is (N+1),
              v_XY(Next, END,  Y, END_Y).
    
