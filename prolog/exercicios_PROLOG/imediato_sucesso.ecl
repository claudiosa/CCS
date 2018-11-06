
h(soc).
h(platao).
h(bruno).
h(gabi).


m(X) :- h(X).
/* para todos homens implicam em mortais */

t_h :- h(X), printf(output,  " \n HOMEM %a ", [ X ]), fail.
t_h :- true.

t_m :- m(X), printf(output, " \n MORTAL: %a ", [ X ]), fail.
t_m :- true.
