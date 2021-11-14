#const max=10.

type(a;b).
ratio(a,b,2). % number of items of type b should be around nearly twice
%the number of items of type a

item(1,T) :- type(T).

{item(I+1,T)} 1 :- item(I,T), I+1 <= max.

cover(T,T',I'+1-R..I') :- ratio(T,T',R), item(I,T), I' = R*I.

:~ cover(T,T',I'), not item(I',T').                [1,T,T',I']
:~ ratio(T,T',R), item(I',T'), not cover(T,T',I'). [1,T,T',I']

:~ item(I,T). [-1,I,T]

#show ratio/3.
#show items(I,T) : item(I,T), not item(I+1,T).