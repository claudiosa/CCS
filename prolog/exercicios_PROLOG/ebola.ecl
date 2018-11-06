
p(a).
p(b).
p(c).
q(1).
q(2).
r(d).
r(e).

teorema(X,Y,Z) :- p(X), q(Y),
                             ( %%% UMA RESTRICAO COM  .... OU
                               (X == 'a' , Y == 2)
                               ;
                               X == 'b'
                              ),
                              r(Z).
print_all :- teorema(X,Y,Z),  write(X), write("   "),
                   write(Y),  write("   "),   write(Z), nl, fail.
print_all.
