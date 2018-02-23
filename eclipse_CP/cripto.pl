/* Solucao 1 com Permutação nas atribuições */

l_letras([ l(s,_), l(e,_), l(n,_), l(d,_),
           l(m,_), l(o,_), l(r,_),
           l(y,_)]).

l_numeros([0,1,2,3,4,5,6,7,8,9]).

cripto_1 :-
         statistics(cputime,Time1),
         l_letras(L),
         l_numeros(N),
         instancia_n_l(N,L),
         cond_1(L),
       /* notrace,
         trace, */
        cond_2(L),nl,
        write('==================================='),nl,
        write(L),nl,
        write('sucesso'), 
        statistics(cputime,Time2),
        Time is Time2 - Time1, nl, write(' Tempo: ===> '),
        write(Time), !.

cripto_1 :- write('fim sem sucesso').

instancia_n_l(N,L) :- atribui(N,L).
instancia_n_l(N,L) :- permutation(N,New),
                      atribui(New,L).

atribui(_,[]).
atribui([Num| R1] , [ l(_,Num) | R2] ):-
        atribui( R1 , R2).


cond_1([l(s,S), l(e,_), l(n,_), l(d,_),
           l(m,M), l(o,_), l(r,_),
           l(y,_)]):-
        M > 0,
        S > 0.

cond_2( [l(s,S), l(e,E), l(n,N), l(d,D),
           l(m,M), l(o,Oo), l(r,R),
           l(y,Y)] ) :-
 ((1000*S) + (100*E) + (10*N) + D) +
 ((1000*M) + (100*Oo) + (10*R) + E) =:=
/* --------------------------------------- */
((10000*M) + (1000*Oo) + (100*N) + (10*E) + Y).

/*
?- cripto_1.

===================================
[l(s, 9), l(e, 5), l(n, 6), l(d, 7), l(m, 1), l(o, 0), l(r, 8), l(y, 2)]
sucesso ===> 29.82

Yes
*/



/* Solução 2  com exclusão a cada atribuição */
atr([],_).
atr([X|L],D) :- member(X,D), delete(D,X,D_novo), atr(L,D_novo).

todos_dif([]).
todos_dif([H|L]) :- dif_H_L(H,L), todos_dif(L).

dif_H_L(_,[]).
dif_H_L(X,[H|L]) :- X =\= H, dif_H_L(X,L). 
                    /* =\= ser for numero */

restricao([S,E,N,D,M,O,R,Y]) :- 
        M > 0, 
        S > 0,
       1000*S + 100*E + 10*N + D +
       1000*M + 100*O + 10*R + E =:=
       10000*M + 1000*O + 100*N + 10*E + Y.
/*
 ou ....
        S =\= 0,
	M =\= 0,
	todos_dif([S,E,N,D,M,O,R,Y]), 
	1000 * S + 100*E + 10*N + D
	+ 1000*M + 100*O + 10*R + E
	=:= 10000*M + 1000*O + 100*N + 10*E + Y.
*/

x_2 :- cripto_2([_,_,_,_,_,_,_,_]).
    cripto_2([S,E,N,D,M,O,R,Y]) :-
      statistics(cputime,Time1),
     atr([S,E,N,D,M,O,R,Y],[0,1,2,3,4,5,6,7,8,9]),
   /* resultados  parciais write([S,E,N,D,M,O,R,Y]),nl, */
   restricao([S,E,N,D,M,O,R,Y]), nl, !,
  write("SUCESSO"), nl, write([S,E,N,D,M,O,R,Y]), 
  statistics(cputime,Time2),
  Time is Time2 - Time1, nl, write(' Tempo: ===> '),
  write(Time).
/*
?- x_2.

[83, 85, 67, 69, 83, 83, 79]
[9, 5, 6, 7, 1, 0, 8, 2]
 Tempo: ===> 17.35

Yes

?- 

[9, 5, 6, 7, 1, 0, 4, 3]
[9, 5, 6, 7, 1, 0, 4, 8]
[9, 5, 6, 7, 1, 0, 8, 2]

[83, 85, 67, 69, 83, 83, 79]   => [9, 5, 6, 7, 1, 0, 8, 2]

Yes
[S, E, N, D, M, O, R, Y]
[9, 5, 6, 7, 1, 0, 8, 2] ... nossa

[S, E, N, D, M, O, R, Y]
[2, 8, 1, 7, 0, 3, 6, 5] ... do frances ...  
e que está certa também .. duas soluções até agora.


  	S 	E 	N 	D
+ 	M 	O 	R 	E
----------------------------------
M 	O 	N 	E 	Y

*/

:- use_module(library('clp/bounds')).

clp_cripto_1 :-
  statistics(cputime,Time1),
  Vars = [S,E,N,D,M,O,R,Y],
  Vars in 0..9,
  M #>= 1,
  all_different(Vars),
  1000 * S + 100*E + 10*N + D
  + 1000*M + 100*O + 10*R + E
  #= 10000*M + 1000*O + 100*N + 10*E + Y,
  label(Vars),

  format('   ~a~a~a~a~n', [S,E,N,D]),
  format('+  ~a~a~a~a~n', [M,O,R,E]),
  writeln('_______'),
  format('= ~a~a~a~a~a~n', [M,O,N,E,Y]), 
   nl, write(' ou '), write([S,E,N,D,M,O,R,Y]),
  statistics(cputime,Time2),
  Time is Time2 - Time1, nl, write(' Tempo: ===> '),
  write(Time).

/*
?- clp_cripto_1.
   9567
+  1085
_______
= 10652

  ou [9, 5, 6, 7, 1, 0, 8, 2]
 Tempo: ===> 0.01
Yes
*/

%
%  Alterando as condições, com transporte de 1. 
$
/* :- use_module(library('clp/bounds')).*/
clp_cripto_2 :-
        statistics(cputime,Time1), 
	Vars = [D,E,Y,N,R,O,S,M],
	Vars in 0..9,
	all_different(Vars),	
	M #\= 0,
	my_add_clp(D, E, 0, Y, Carry),
	my_add_clp(N, R, Carry, E, Carry1),
	my_add_clp(E, O, Carry1, N, Carry2),
	my_add_clp(S, M, Carry2, O, M),
	label(Vars),
	format('   ~a~a~a~a~n', [S,E,N,D]),
	format('+  ~a~a~a~a~n', [M,O,R,E]),
	writeln('_______'),
	format('= ~a~a~a~a~a~n', [M,O,N,E,Y]), 
        nl, write(' ou '), write([S,E,N,D,M,O,R,Y]),
        statistics(cputime,Time2),
        Time is Time2 - Time1, nl, write(' Tempo: ===> '),
        write(Time).
	
my_add_clp(A, B, Carry, T, 0) :-
	T #= A + B + Carry,
	T #< 10.
	
my_add_clp(A, B, Carry, T, 1) :-
	T1 #= A + B + Carry,
	T1 #>= 10,
	T #= T1 - 10.
/*
?- clp_cripto_2.
   9567
+  1085
_______
= 10652

 ou [9, 5, 6, 7, 1, 0, 8, 2]
 Tempo: ===> 0.01

*/

/*******************************************/
/* Uma 3a. Solução */

smm :-
        statistics(cputime,Time1), 
        X = [S,E,N,D,M,O,R,Y],
        Digits = [0,1,2,3,4,5,6,7,8,9],
        assign_digits(X, Digits),
        M > 0,
        S > 0,
                  1000*S + 100*E + 10*N + D +
                  1000*M + 100*O + 10*R + E =:=
        10000*M + 1000*O + 100*N + 10*E + Y,
        write(X),nl,
         statistics(cputime,Time2),
        Time is Time2 - Time1, nl, write(' Tempo: ===> '),
        write(Time).

select(X, [X|R], R).
select(X, [Y|Xs], [Y|Ys]):- select(X, Xs, Ys).

assign_digits([], _List).
assign_digits([D|Ds], List):-
        select(D, List, NewList),
        assign_digits(Ds, NewList).

/*
?- smm.
[9, 5, 6, 7, 1, 0, 8, 2]

 Tempo: ===> 11.9

Yes
*/

