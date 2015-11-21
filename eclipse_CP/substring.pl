
subs(A,B) :- sub(A,B,A).
/* A está contida em B */
sub([],_,_).
sub([A|B] , [C|D] , Lcopia) :- A == C, sub( B, D, Lcopia).
sub([A|_] , [C|D] , Lcopia) :- A \== C, sub(Lcopia,D, Lcopia).


/*
?- subs([a,b,c],[x,d,a,b]).
fail.
?- subs([a,b,c],[x,d,a,b,x,x,x,a,b,c,y]).
true .
?- subs([a,b,c],[x,d,a,b,x,x,x,a,b,c]).
true .
?- subs([a,b,c],[a,b,x,d,a,b,x,x,x,a,b,c]).
true .
?- subs([a,b,c],[a,b,c,x,d,a,b,x,x,x,a,b,c]).
true .
?- 
*/
