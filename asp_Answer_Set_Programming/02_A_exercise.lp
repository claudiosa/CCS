% to run: $ clingo 02_A_exercise.lp 0
%We want to represent the statement that “all professors are adult” using an ASP program. There are different ways to encode this statement into an ASP program. Consider the following two programs:
%Π1: 

prof (alice). 
-adult(bob).

adult (X) :- prof (X).
child(X) :- -adult (X). %%% STRONG NEGATION
%%%:- child(X) ; not child(X).  %%% Optional
%{not child(X) , adult (X)}.

:- adult(X) ; not adult(X). 
:- prof (X) ; not prof (X).

#show prof/1. %% to show only the profs
#show adult/1.
#show child/1.
