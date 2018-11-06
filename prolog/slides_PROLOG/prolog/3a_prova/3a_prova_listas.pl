

/* 1a. facil 2 min */
filtro_1([],[]):- !.
filtro_1([(_ ,B,_)|L1], [B|L2]) :- filtro_1(L1 , L2 ).

/*
?- filtro_1([ (3, a, 3), (4, b, 4), (5, c, 5)], X).
X = [a, b, c].
?- filtro_1([ (3, a, 3), (4, b, 4)],  X).
X = [a, b].
?- filtro_1([],  X).
X = [].
*/

/* 2a. facil 2 min */
monta_1([],[]):- !.
monta_1([A,B], [(A,'*',B)] ).
monta_1([A], [('#',A,'#')] ).
monta_1([A,B,C|L1], [(A,B,C)|L2] ) :- monta_1(L1 , L2 ).

/*
?- monta_1([a,b,c, 1,2,3,4,5],X).
X = [ (a, b, c), (1, 2, 3), (4, *, 5)]  ==> sobraram 2
?- monta_1([a,b,c, 1,2,3,4],X).
X = [ (a, b, c), (1, 2, 3), (#, 4, #)] .  ==> sobrou 1
?- monta_1([a,b,c, 1,2,3],X).  
X = [ (a, b, c), (1, 2, 3)] .
?- monta_1([],X).
X = []
*/

/* 3a - facil */
monta_N(N,L) :- aux_3(N,L1), reverse(L1,L).
aux_3(0,[]) :- !.
aux_3(N, [N|L]) :- N1 is (N-1), aux_3(N1, L).
/*
?- monta_N(8,X).
X = [1, 2, 3, 4, 5, 6, 7, 8].
?- monta_N(0,X).
X = [].
*/


/* 4a. facil */
filtro_2(_,[],[]):- !.
filtro_2(X, [(A,B) |L1], [A | L2]):- X == B, filtro_2(X, L1, L2).
filtro_2(X, [(A,B) |L1], [B | L2]):- X == A, filtro_2(X, L1, L2).
filtro_2(X, [_ |L1], L2):-  filtro_2(X, L1, L2).

/*
?- filtro_2(2, [(1,2),(b,2), (2,4),(2,x)], L).
L = [1, b, 4, x] .
?- filtro_2(2, [(1,12),(b,12), (12,4),(12,x)], L).
L = [] .
?- filtro_2(2, [], L).
L = [] .
*/

/* 5a. facil */
monta_dupla(_,[],[]):- !.
monta_dupla([],_,[]):- !.
monta_dupla([A|L1],[B|L2],[(A,B)| L3]) :- monta_dupla(L1,L2,L3).
/*
?- monta_dupla([1,2,3,4,45],[a,b,c,d,e,f,h], X).
X = [ (1, a), (2, b), (3, c), (4, d), (45, e)].
?- monta_dupla([1,2,3,4,45],[], X).
X = [] .
?- monta_dupla([1,2,3,4,45],[a,b,c], X).
X = [ (1, a), (2, b), (3, c)] .
*/


/* 6a. 30  minutos */
num_l(0,[]):- !.
num_l(N,L) :- aux0(N,N,L).

aux0(_, 0, [])  :- !.
aux0(N, X, [L1|L2]) :-   aux1(N,X,L1), X1 is X-1, aux0(X1, X1, L2).

%% aux0(N, X, L3) :-   aux1(N,X,L1), X1 is X-1, aux0(X1, X1, L2), L3 = [L1,L2].

aux1(_,0,[]) :- !.
aux1(N, X, [N|L3]) :- X1 is X-1,  aux1(N,X1,L3).

/*
?- num_l(7,X).
X = [[7, 7, 7, 7, 7, 7, 7], [6, 6, 6, 6, 6, 6], [5, 5, 5, 5, 5], [4, 4, 4, 4], [3, 3, 3], [2, 2], [1]].

?- num_l(2,X).
X = [[2, 2], [1]].
*/

/* 7a. questao -- achata */
achata( [],[]):- !.
achata( [A |L1] , L3) :-  achata(L1,L2), append(A, L2, L3) .

/*
?- num_l(0,X), achata(X,Y).
X = [],
Y = [] .
?- num_l(7,X), achata(X,Y).
X = [[7, 7, 7, 7, 7, 7, 7], [6, 6, 6, 6, 6, 6], [5, 5, 5, 5, 5], [4, 4, 4, 4], [3, 3, 3], [2, 2], [1]],
Y = [7, 7, 7, 7, 7, 7, 7, 6, 6|...].
?- num_l(3,X), achata(X,Y).
X = [[3, 3, 3], [2, 2], [1]],
Y = [3, 3, 3, 2, 2, 1].
*/


/* 8a. questao */

duplica_x([],[]).
duplica_x([X | L1],[ (X,'#',X) | L2]) :- duplica_x(L1, L2). 

/*
?- duplica_x([3,4,5],X).
X = [ (3, #, 3), (4, #, 4), (5, #, 5)].
?- duplica_x([],X).
X = [].
*/

/* 9a. questao */
m_consec([], []) :- !.
m_consec([Y], [(Y,'#')]) :- !.
m_consec([X,Y], [(X,Y)]) :- !.
m_consec([X,Y | L1], [(X,Y) | L2]):- m_consec( [Y | L1], L2).

/*
?- monta_n(1,X),  m_consec(X,Z).
X = [1],
Z = [ (1, #)].
?- monta_n(2,X),  m_consec(X,Z).
X = [1, 2],
Z = [ (1, 2)].
?- monta_n(3,X),  m_consec(X,Z).
X = [1, 2, 3],
Z = [ (1, 2), (2, 3)].
*/
