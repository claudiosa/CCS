% Data: 3/05/2008
:- use_module(library(clpfd)). 
%:- use_module(library(bounds)). 


tudo :- findall( X, domo(X), L1), length(L1,X1), write(X1), nl.
/*
           /* 2241 pares válidos  ===> escolher 28 ...
            6480 gerados inicialmente
			2889 elimina duplicados.
          */
*/
domo([A,B,C]) :-
   Var_1 = [A,B], 
   Var_2 = [C],
   Var_1 in 1 .. 9,
   domain_1(X),
   C in X, nl,
  fd_dom(FD, Dom),
  /* 
   A*B #\= C,
   labeling([ff],[A,B,C]).
*/

/* remove os duplicados */
remove_duplo([],[]).
remove_duplo([[A,B,C]|L1], [[A,B,C]|L2]) :- \+ member( [B,A,_] , L1), remove_duplo( L1 , L2 ).
remove_duplo([[_,_,_]|L1], L2) :-  remove_duplo( L1 , L2 ).

/* duplicated are removed */
rem_double([],[]).
rem_double([A|L1], [A|L2]) :- \+ member( A , L1), rem_double( L1 , L2 ).
rem_double([_|L1], L2) :-  rem_double( L1 , L2 ).


generate_domain([], _ ).
generate_domain([ X ], [ Z | L1 ]) :-  
					Z is X*X,
					d_1_9(L2),
					delete_up_to(L2, X, L3),
					generate_domain(L3 , L1 ).

/* the first multiplies by the rest - each two */
generate_domain([ N1, N2 | L1 ],[ Z | L2 ]) :- 
                 Z is N1*N2,
				generate_domain([N1|L1], L2).


d_1_9([1,2,3,4,5,6,7,8,9]).

/* delete all element in ordered list up to  a given X */
delete_up_to([], _, []).
delete_up_to([X|L], X, L).
delete_up_to([_|L], X, L2) :- delete_up_to(L, X, L2).

domain_1(Domain) :-
  Var = [1,2,3,4,5,6,7,8,9],
  generate_domain(Var,  Daux ),nl,
  cp(Daux,Temp),
  rem_double(Temp,Temp2),
  sort(Temp2,Domain).
  /* 36 valores */
  

  
cp([],[]).
cp([A|L1],[A|L2]) :-
                    \+var(A),
                    cp(L1,L2).
cp(_,[]).

mult(1).
mult(X) :- 
         X mod 2 =:= 0, !;
         X mod 3 =:= 0, !;
         X mod 5 =:= 0, !;
         X mod 7 =:= 0, !.


