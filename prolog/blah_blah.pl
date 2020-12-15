blah :- a(X) , b(X).
blah :- a(_) , b(_).
a(1).
b(2).



surprise1([],[]).
surprise1([_|A],[_|B]):- surprise1(A,B).
