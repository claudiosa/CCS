:- use_module(another_module , [p/2] ).  
 %%%% use_module ===> take care 
% ciaosh 
%Ciao 1.20.0 [LINUXx86_64]


main :- p1, q1.
q(1,2).
p1 :- p(X,Y) , write(X), nl, write(Y), nl.
q1 :- q(X,Y) , write(X), nl, write(Y).
/*
$ ciaoc my_first.pl
[ccs@vosges tests]$ ./my_first 
a
b
1
2[ccs@vosges tests]$ 
*/