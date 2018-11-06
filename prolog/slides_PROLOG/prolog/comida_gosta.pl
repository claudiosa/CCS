%% Considering the following will give some practice
%% in thinking about backtracking.
%% ?- likes(sam,dahl).
%% ?- likes(sam,chop_suey).
%% ?- likes(sam,pizza).
%% ?- likes(sam,chips).
%% ?- likes(sam,curry).


inic_1 :- likes(X,Y), write(X), write(" gosta de "), write(Y), nl, fail.

likes(socrates, X) :- chinese(X).

likes(sam,Food) :-
        indian(Food),
        mild(Food).
likes(sam,Food) :-
        chinese(Food).
likes(sam,Food) :-
        italian(Food).
likes(sam,chips).

indian(curry).
indian(dahl).
indian(tandoori).
indian(kurma).

mild(dahl).
mild(tandoori).
mild(kurma).

chinese(chow_mein).
chinese(chop_suey).
chinese(sweet_and_sour).

italian(pizza).
italian(spaghetti).
