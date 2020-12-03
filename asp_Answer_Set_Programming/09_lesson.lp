p( a ; b ; c ).
q( d ; e ; f ).


%{r(X,Y) : p(X)} = 1 :- q(Y).

:- {r(X,Y) : p(X) , q(Y)} = 1 .

#show r/2.