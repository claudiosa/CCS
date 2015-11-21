
a(1).
a(2).
a(3).

y :- findall(X, a(X), L), 
     nl, 
     write(L).
