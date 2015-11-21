%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-lib(ic).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
Menor (0) ou Maior (1)
UMA IDEIA MELHOR ....
*/

go :- reify(8, 5, X1), writeln( " x1 " : X1),
      reify(5, 8, X2), writeln( " x2 " : X2).

reify(A,B, VAR_REIFY):-
	VAR_REIFY #::[0..1],
	
	(VAR_REIFY #=1 and 1 #= (A#>=B)) 
    or
	(VAR_REIFY #=0 and 0 #= (A#>=B)) .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
?- go.
Yes (0.00s cpu)
 x1  : 1
 x2  : 0

?- go2.
Yes (0.00s cpu)
 x1  : 1
 x2  : 0
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
go2 :- 
    reify2(8, 5, X1), writeln( " x1 " : X1),
    reify2(5, 8, X2), writeln( " x2 " : X2).

reify2(A,B, VAR_REIFY):-
	VAR_REIFY #::[0..1],
	( (A#>=B) ->
	   VAR_REIFY #= 1
       ; 	    
	   VAR_REIFY #=0
	).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
