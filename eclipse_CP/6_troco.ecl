:- lib(ic). 
:- lib(branch_and_bound).

% moedas de 1, 3, 4 unidades.

troco(Moedas, Valor) :-
    Moedas = [M1, M2, M3],
    Moedas #:: [0..100],
    
    1 * M1 + 3 * M2 + 4 * M3 #= Valor,
    Qt #= M1 + M2 + M3,
    bb_min( labeling(Moedas), Qt, bb_options{} )
