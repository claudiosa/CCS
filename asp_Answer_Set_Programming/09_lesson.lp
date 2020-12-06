p( a ; b ).
q( d ; e ).

%1 {r(X,Y) : p(X)} 1 :- q(Y).
1 {s(X,Y) : q(X), p(Y)} 1. % :- p(Y).
{r(X,Y) : q(X)} = 1 :- p(Y).

%:- {r(X,Y) : p(X) , q(Y)} = 1 .

#show r/2.
#show s/2.