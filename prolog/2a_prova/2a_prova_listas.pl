/* valor medio de uma lista  numerica */
med_lista([],0).
med_lista(L,M) :-
	soma(L,Total),
	length(L,C),
	M is (Total/C).
	
soma([],0).
soma([X|L], S) :- 
        soma(L, S_ant),
        S is (X + S_ant).	


/*  marka( In, Elem, X, Out) iff input list In will change to output list Out
    marked with an X after Elem.
    Fails if In does not contain Elem.
*/
ad_depois([],_,_,[]).
ad_depois( [Elem|T], Elem, X, [Elem,X|T] ).

ad_depois( [H|T], Elem, X, [H|T1] ) :-
    ad_depois( T, Elem, X, T1 ).

/*  doubl( In, Out) iff Out is the same as In after replacing two adjacent
    occurrences
    of any element by one occurrence of that element.
*/
del_duplos( [], []).

del_duplos( [ Elem, Elem| X], [ Elem| Y]) :-
   del_duplos( X, Y).

del_duplos( [ X| R1], [ X| R2]) :-
   del_duplos( R1, R2).


/*  Aux. predicates taken from NBS/ICST Prolog Utility Library vers 11.25.86
    member_rest( Elem, List, Rest) iff Elem is a member
    of List and Rest is the rest of the list following Elem.
*/
elem_resto( Elem, L , 'Elemento nao estah na lista') :- not(member(Elem, L)), !.
elem_resto( Elem, [ Elem| Rest], Rest).

elem_resto( Elem, [ _| Rest], Rest_rest) :-
   elem_resto( Elem, Rest, Rest_rest).


/* intersecao de duas listas  retorna */


inter([],_,[]).
inter(_,[],[]).
inter([X|L], L2, [X|L3]) :- member(X,L2), inter(L, L2, L3).
inter([X|L], L2, L3) :- not(member(X,L2)), inter(L, L2, L3).

/* troca ocorrencias X, Y em L1, retorna L2*/

troca(_,_,[],[]).
troca(X,Y,[Y|L1],[X|L2]) :-troca(X,Y,L1,L2).
troca(X,Y,[Z|L1],[Z|L2]) :- troca(X,Y,L1,L2).

/* conta ocorrencias */

conta(_,[],0).
conta(X, [X|L], N) :- conta(X,L,Nant), N is (Nant+1).
conta(X, [Y|L], N) :- X \== Y, conta(X,L,N).
