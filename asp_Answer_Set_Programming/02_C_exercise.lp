% to run: $ clingo 02_C_exercise.lp 0
%ΠAdd Closed World Assumption rules into Π, to form a new program Π′, so that we can always derive negative information for all these predicates. Also transform your Π′ into clingo syntax and run it under clingo.1: 
r(a).
r(b).
s(c).

%% Added freely for Closed World Assumption hipotheses
q(1,2). 
q(aa,bb).
p(3,4). 
p(aa,bb).
%%%%%%%
%% rules slightly modified to build sets
{p(X, Y): q(X,Y)} :- not q(X, Y).
{q(X, Y): p(X,Y)} :- not p(X, Y).


#show p/2. 
#show q/2.
#show r/1.
#show s/1.