% Autor: Marcelo
% Data: 16/06/2019

%árvore de teste
arvore([[[[],1,[]],3,[[],4,[]]],5,[[[],6,[]],8,[[[],9,[]],10,[[],12,[]]]]]).

%principal
determina_nivel(Arv,Prof) :-
   varre_arvore_iterativo([Arv],0,Prof).

varre_arvore_iterativo([],Cont,Cont) :- !.
varre_arvore_iterativo(Arv,Cont,Prof) :-
     expande(Arv,NArv),
     NCont is Cont+1,
     varre_arvore_iterativo(NArv,NCont,Prof),!.

expande([],[]) :- !.
expande([[[],_,[]]|Fs],Rs) :-
  expande(Fs,Rs),!.
expande([[[],_,Ad]|Fs],[Ad|Rs]) :-
  expande(Fs,Rs),!.
expande([[Ae,_,[]]|Fs],[Ae|Rs]) :-
  expande(Fs,Rs),!.
expande([[Ae,_,Ad]|Fs],[Ae,Ad|Rs]) :-
  expande(Fs,Rs),!.

/* teste
?- arvore(A),determina_nivel(A,P).
A = [[[[], 1, []], 3, [[], 4, []]], 5, [[[], 6, []], 8, [[[], 9|...], 10, [...|...]]]],
P = 4.
*/



