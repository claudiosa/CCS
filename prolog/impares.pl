 

x(1).
x(5).
x(3).
par(PAR) :- x(N1),
            x(N2), 
          N1 =\= N2, 
	  is(PAR , (N1+N2)), 
  	write(PAR), write(' .... '), write(N1), write(' .... '),
        write(N2), nl, fail.
/*, fail. */ 
par( 0 ) :- true.

inicio :- nl, par(_).%%,  halt.
/* :-inicio.
*/
